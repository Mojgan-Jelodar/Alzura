//
//  OrderView.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import UIKit

final class OrderView: UIView, UIContentView {

    var configuration: UIContentConfiguration {
        didSet {
            self.setUpConfiguration()
        }
    }

    private lazy var orderNoLabel: UILabel = {
        let orderNoLabel = UILabel()
        orderNoLabel.font = .systemFont(ofSize: orderNoLabel.font.pointSize, weight: .heavy)
        orderNoLabel.numberOfLines = .zero
        orderNoLabel.lineBreakMode = .byWordWrapping
        orderNoLabel.translatesAutoresizingMaskIntoConstraints = false
        return orderNoLabel
    }()
    
    private lazy var orderDateLabel: UILabel = {
        let orderDateLabel = UILabel()
        orderDateLabel.font = .systemFont(ofSize: orderDateLabel.font.pointSize, weight: .heavy)
        orderDateLabel.numberOfLines = .zero
        orderDateLabel.lineBreakMode = .byWordWrapping
        orderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        orderDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return orderDateLabel
    }()
    
    private lazy var paymentCaptionLabel: UILabel = {
        let paymentCaptionLabel = UILabel()
        paymentCaptionLabel.text = R.string.orders.paymentMethod().appending(":")
        paymentCaptionLabel.font = .systemFont(ofSize: paymentCaptionLabel.font.pointSize, weight: .bold)
        paymentCaptionLabel.numberOfLines = .zero
        paymentCaptionLabel.lineBreakMode = .byWordWrapping
        paymentCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentCaptionLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return paymentCaptionLabel
    }()
    
    private lazy var paymentLabel: UILabel = {
        let paymentLabel = UILabel()
        paymentLabel.font = .systemFont(ofSize: paymentLabel.font.pointSize, weight: .regular)
        paymentLabel.numberOfLines = .zero
        paymentLabel.lineBreakMode = .byWordWrapping
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        return paymentLabel
    }()
    
    private lazy var priceCaptionLabel: UILabel = {
        let priceCaptionLabel = UILabel()
        priceCaptionLabel.font = .systemFont(ofSize: priceCaptionLabel.font.pointSize, weight: .bold)
        priceCaptionLabel.text = R.string.orders.price().appending(":")
        priceCaptionLabel.numberOfLines = .zero
        priceCaptionLabel.lineBreakMode = .byWordWrapping
        priceCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceCaptionLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return priceCaptionLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .systemFont(ofSize: priceLabel.font.pointSize, weight: .regular)
        priceLabel.numberOfLines = .zero
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setUpViews()
        setUpConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        addSubview(orderNoLabel)
        addSubview(orderDateLabel)
        addSubview(paymentCaptionLabel)
        addSubview(paymentLabel)
        addSubview(priceCaptionLabel)
        addSubview(priceLabel)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            orderNoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.padding8),
            orderNoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.padding8),
            
            orderDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.padding8),
            orderDateLabel.topAnchor.constraint(equalTo: self.orderNoLabel.topAnchor),
            orderDateLabel.leadingAnchor.constraint(equalTo: orderNoLabel.trailingAnchor, constant: Layout.padding8),
            
            paymentCaptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.padding8),
            paymentCaptionLabel.topAnchor.constraint(equalTo: self.orderNoLabel.bottomAnchor, constant: Layout.padding8),
            
            paymentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.padding8),
            paymentLabel.topAnchor.constraint(equalTo: paymentCaptionLabel.topAnchor),
            paymentLabel.leadingAnchor.constraint(equalTo: paymentCaptionLabel.trailingAnchor, constant: Layout.padding8),
            
            priceCaptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.padding8),
            priceCaptionLabel.topAnchor.constraint(equalTo: self.paymentLabel.bottomAnchor, constant: Layout.padding8),
            priceCaptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.padding8),
            
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.padding8),
            priceLabel.topAnchor.constraint(equalTo: self.priceCaptionLabel.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceCaptionLabel.trailingAnchor, constant: Layout.padding8),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.padding8)
            
        ])
    }

    private func setUpConfiguration() {
        guard let configuration = self.configuration as? OrderView.Configuration,
              let order = configuration.order else { return  }
        orderNoLabel.text = order.orderId
        orderDateLabel.text = order.date
        paymentLabel.text = order.usedPayment
        priceLabel.text = order.price
    }
}
extension OrderView {
    struct Configuration: UIContentConfiguration {
        let order: OrderViewModelOutput?

        init(
            order: OrderViewModelOutput
        ) {
            self.order = order
        }

        func makeContentView() -> UIView & UIContentView {
            OrderView(configuration: self)
        }

        func updated(for state: UIConfigurationState) -> OrderView.Configuration {
            self
        }
    }
}
extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
