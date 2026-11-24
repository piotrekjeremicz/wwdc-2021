//
//  ScrollView.swift
//  wwdc2021
//
//  Created by Piotrek on 16/04/2021.
//

import SwiftUI


extension UIScrollView {
    public struct SwiftUI<Content: View>: UIViewControllerRepresentable {
        var content: () -> Content
        var showsIndicators: Bool
        
        @Binding var contentCenter: CGPoint
        @State var contentOffset: CGPoint = .init(x: 0, y: 0)
        
        public init(contentCenter: Binding<CGPoint>, showsIndicators: Bool, @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self._contentCenter = contentCenter
            self.showsIndicators = showsIndicators
        }
        
        public func makeCoordinator() -> some UIScrollView.Delegate {
            UIScrollView.Delegate(contentOffset: $contentOffset, contentCenter: $contentCenter)
        }
        
        public func makeUIViewController(context: Context) -> UIScrollView.Controller {
            let viewController = UIScrollView.Controller(showsIndicators: showsIndicators)
            viewController.delegate = context.coordinator
            viewController.hostingController.rootView = AnyView(self.content())
            viewController.scrollView.contentOffset = .init(x: contentCenter.x - viewController.scrollView.frame.size.width/2, y: contentCenter.y - viewController.scrollView.frame.size.height/2)
            
            return viewController
        }
        
        public func updateUIViewController(_ viewController: UIScrollView.Controller, context: Context) {
            viewController.scrollView.contentOffset = .init(x: contentCenter.x - viewController.scrollView.frame.size.width/2, y: contentCenter.y - viewController.scrollView.frame.size.height/2)
            viewController.hostingController.rootView = AnyView(self.content())
        }
    }
}

extension UIScrollView {
    public class Controller: UIViewController {
        
        public var delegate: UIScrollView.Delegate?

        private let showsIndicators: Bool

        public lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.delegate = delegate
            
            scrollView.showsVerticalScrollIndicator = showsIndicators
            scrollView.showsHorizontalScrollIndicator = showsIndicators
            return scrollView
        }()

        public var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))

        public init(showsIndicators: Bool) {
            self.showsIndicators = showsIndicators

            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            self.showsIndicators = false

            super.init(coder: coder)
        }

        public override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
            
            hostingController.willMove(toParent: self)
            scrollView.addSubview(hostingController.view)
            setConstraints(of: hostingController.view, to: scrollView)
            hostingController.didMove(toParent: self)
        }

        private func setupView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            
            setConstraints(of: scrollView, to: view)
        }
        
        private func setConstraints(of viewA: UIView, to viewB: UIView) {
            viewA.translatesAutoresizingMaskIntoConstraints = false
            viewB.addConstraints([
                viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
                viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
                viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
                viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
            ])
        }
    }
}

extension UIScrollView {
    final public class Delegate: NSObject, UIScrollViewDelegate {
        @Binding var contentCenter: CGPoint
        @Binding var contentOffset: CGPoint
        
        public init(contentOffset: Binding<CGPoint>, contentCenter: Binding<CGPoint>) {
            _contentCenter = contentCenter
            _contentOffset = contentOffset
        }
                
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.contentOffset = scrollView.contentOffset
            self.contentCenter = .init(x: scrollView.contentOffset.x + scrollView.frame.size.width/2, y: scrollView.contentOffset.y + scrollView.frame.size.height/2)
        }
    }
}
