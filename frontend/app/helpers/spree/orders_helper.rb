module Spree
  module OrdersHelper
    def order_just_completed?(order)
      flash[:order_completed] && order.present?
    end

    def generate_order_to_text_query(order)
      { txt: 
        [
          "#{Spree.t(:order_content_introduction_txt_query, number: order.number).strip}\n",
          "*#{Spree.t(:products)}*\n",
          "#{
            order.line_items.includes(variant: :product).each_with_index.map { |line_item, index|
              "#{index + 1}) #{line_item.variant.product.name} (#{line_item.quantity}x #{line_item.display_price.to_s})"
            }
            .join("\n")
          }\n",
          "Total: #{order.display_total.to_s}"
        ].join("\n")
      }
      .to_query
      .gsub('txt=', '')
    end
  end
end
