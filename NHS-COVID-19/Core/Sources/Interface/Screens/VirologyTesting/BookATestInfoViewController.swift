//
// Copyright © 2020 NHSX. All rights reserved.
//

import Localization
import UIKit

public protocol BookATestInfoViewControllerInteracting {
    func didTapTestingPrivacyNotice()
    func didTapAppPrivacyNotice()
    func didTapBookATestForSomeoneElse()
    func didTapBookATest()
}

private class BookATestInfoContent: BasicStickyFooterScrollingContent {
    public typealias Interacting = BookATestInfoViewControllerInteracting
    
    private let interactor: Interacting
    
    public init(interactor: Interacting) {
        self.interactor = interactor
        
        super.init(
            scrollingViews: [
                UILabel().styleAsPageHeader().set(text: localize(.virology_book_a_test_heading)),
                UILabel().styleAsBody().set(text: localize(.virology_book_a_test_paragraph1)),
                UILabel().styleAsBody().set(text: localize(.virology_book_a_test_paragraph2)),
                UILabel().styleAsBody().set(text: localize(.virology_book_a_test_paragraph3)),
                UILabel().styleAsBody().set(text: localize(.virology_book_a_test_paragraph4)),
                LinkButton(
                    title: localize(.virology_book_a_test_testing_privacy_notice),
                    action: interactor.didTapTestingPrivacyNotice
                ),
                UILabel().styleAsBody().set(text: localize(.virology_book_a_test_paragraph5)),
                LinkButton(
                    title: localize(.virology_book_a_test_app_privacy_notice),
                    action: interactor.didTapAppPrivacyNotice
                ),
                UILabel().styleAsBody().set(text: localize(.virology_book_a_test_paragraph6)),
                LinkButton(
                    title: localize(.virology_book_a_test_book_a_test_for_someone_else),
                    action: interactor.didTapBookATestForSomeoneElse
                ),
            ],
            footerTopView: PrimaryLinkButton(
                title: localize(.virology_book_a_test_button),
                action: interactor.didTapBookATest
            )
        )
    }
}

public class BookATestInfoViewController: StickyFooterScrollingContentViewController {
    public typealias Interacting = BookATestInfoViewControllerInteracting
    
    private let shouldHaveCancelButton: Bool
    private let content: BookATestInfoContent
    
    public init(interactor: Interacting, shouldHaveCancelButton: Bool) {
        self.shouldHaveCancelButton = shouldHaveCancelButton
        content = BookATestInfoContent(interactor: interactor)
        super.init(content: content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = localize(.virology_book_a_test_title)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if shouldHaveCancelButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: localize(.cancel), style: .done, target: self, action: #selector(didTapCancel))
        }
    }
    
    @objc private func didTapCancel() {
        navigationController?.dismiss(animated: true)
    }
}
