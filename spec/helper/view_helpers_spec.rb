require 'spec_helper'

feature 'Application Helper' do
  scenario '.format_icon_url' do
    absolute_url = 'http://50.97.56.226:3002/images/svg/it.svg'
    relative_url = '/cloud-computing/images/plat_icon_sml.png'

    sanitized_absolute_url = format_icon_url(absolute_url)
    sanitized_relative_url = format_icon_url(relative_url)

    expect(sanitized_absolute_url).to eq('http://50.97.56.226:3002/images/svg/it.svg')
    expect(sanitized_relative_url).to eq('http://ibm.com/cloud-computing/images/plat_icon_sml.png')
  end
end
