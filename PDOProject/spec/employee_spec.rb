describe 'Casos de Testes com Capybara' do

    before(:each) do
        visit ''
    end

    firstName = 'ZW1wbG95ZWUjJGZpcnN0X25hbWVAM2RzZnNkZioqOTkzNDMyNA=='
    lastName = 'ZW1wbG95ZWUjJGxhc3RfbmFtZUAzZHNmc2RmKio5OTM0MzI0'
    adress = 'ZW1wbG95ZWUjJEFkZHJlc3NAM2RzZnNkZioqOTkzNDMyNA=='
    city = 'ZW1wbG95ZWUjJENpdHlAM2RzZnNkZioqOTkzNDMyNA=='
    state = 'ZW1wbG95ZWUjJFN0YXRlQDNkc2ZzZGYqKjk5MzQzMjQ='
    zip = 'ZW1wbG95ZWUjJFppcEAzZHNmc2RmKio5OTM0MzI0'



    it 'Should add an employee' do

        click_link 'Add'
        fill_in firstName, with: 'Alicia'
        fill_in lastName, with: 'Parker'
        fill_in adress, with: 'Blv 123'
        fill_in city, with: 'San Francisco'
        fill_in state, with: 'California'
        fill_in zip, with: '12345678'
        click_button 'Save'
        expect(find('.message_content')).to have_content 'Operation done successfully'
    end

    it 'Should edit an employee' do

        name = find('.table-condensed', text: 'Alicia')
        name.all('.pdocrud-button-edit')[0].click
        
        fill_in firstName, with: 'Alicia EDIT'
        fill_in lastName, with: 'Parker EDIT'
        fill_in adress, with: 'Blv 123 EDIT'
        fill_in city, with: 'San Francisco EDIT'
        fill_in state, with: 'California EDIT'
        fill_in zip, with: '12345678 EDIT'
        click_button 'Save'
        expect(find('.message_content')).to have_content 'Operation done successfully'

    end

    it 'Should delete a register' do

        name = find('.table-condensed', text: 'Alicia EDIT')
        name.all('.pdocrud-button-delete')[0].click

        msg = page.driver.browser.switch_to.alert.text
        expect(msg).to eql 'Are you sure to delete this record?'
        page.driver.browser.switch_to.alert.accept

    end

    it 'Should cancel a clean all the fields in Adds page' do

        click_link 'Add'

        fill_in firstName, with: 'AAA'
        fill_in lastName, with: 'PPP'
        fill_in adress, with: 'Blv 123'
        fill_in city, with: 'SanFrsc'
        fill_in state, with: 'Calix'
        fill_in zip, with: 'xxxxxxxx'

        click_button 'Cancel'

        expect(find_field(firstName).value).to eq ''
        expect(find_field(lastName).value).to eq ''
        expect(find_field(adress).value).to eq ''
        expect(find_field(city).value).to eq ''
        expect(find_field(state).value).to eq ''
        expect(find_field(zip).value).to eq ''

    end

    it 'Should order First Name column starting by the names with the letter Z' do

        click_link 'Add'

        fill_in firstName, with: 'ZZZZ'
        fill_in lastName, with: 'Parker'
        fill_in adress, with: 'Blv 123'
        fill_in city, with: 'San Francisco'
        fill_in state, with: 'California'
        fill_in zip, with: '12345678'
   
        click_button 'Save'
        click_button 'back'
        
        find('span', text: 'First name').click
        sleep 1
        find('span', text: 'First name').click

        expect(find(:xpath, "/html/body/div[1]/div/section[2]/section/div/div[3]/div[2]/div/div/table/tbody/tr[1]/td[4]")).to have_content 'ZZZZ'

    end


end    



