require 'spec_helper'

feature ProductAPI do
  scenario '.format_JSONP' do
    input = 'callback([\'key\':\'value\']);'
    output = ProductAPI.format_JSONP(input)

    expect(output).not_to include('callback')
  end

  scenario '.fetch_products' do
    products = ProductAPI.fetch_products

    expect(products).to be_a(Array)
  end

  scenario '.build_class' do
    input = 'IBM Product Name'  
    output = ProductAPI.build_class(input)

    expect(output).to eq('ibm-product-name')
  end

  scenario '.search_products' do
    input = 'firewall'
    output = ProductAPI.search_products(input)

    expect(output[0][:name]).to eq('Hardware firewall')
  end
end
