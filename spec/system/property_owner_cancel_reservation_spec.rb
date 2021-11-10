require 'rails_helper'

describe 'Owner view own reservation' do
  it 'and cancel same day of start reservation' do
    owner = create(:property_owner, email: 'alessandro@owner.com', password: '123456')
    property = create(:property, title: 'Casa na Alvora, Manaus AM', property_owner: owner)
    reservation = create(:property_reservation, property: property, status: 'accepted' )
  
    login_as owner, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'
    click_on 'Casa na Alvora, Manaus AM'
    click_on 'Ver Reserva'
    click_on 'Cancelar Reserva'

    expect(page).to have_content('Reserva cancelada com sucesso!')
    expect(page).to current_path(property_path(property))
    expect(page).to have_content('Casa na Alvora, Manaus AM')
    expect(page).not_to have_link('Aceitar Reserva')
    expect(page).not_to have_content('Status: Aceito')
    expect(page).not_to have_content('Status: Rejeitado')
    expect(page).not_to have_content('Status: Pendente')
    expect(page).to have_content('Status: Reserva cancelada')
    expect(page).to have_content('Escreva porque vôce cancelou')
    expect(page).to have_link('Enviar')
  end
end