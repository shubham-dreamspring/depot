# frozen_string_literal: true

require 'application_system_test_case'

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test 'check dynamic fields' do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Checkout'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Po number'

    select 'check', from: 'Pay type'
    assert has_field? 'Routing number'
    assert has_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Po number'

    select 'Credit card', from: 'Pay type'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_field? 'Credit card number'
    assert has_field? 'Expiration date'
    assert has_no_field? 'Po number'

    select 'Purchase order', from: 'Pay type'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_field? 'Po number'
  end
end
