require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:encrypted_password) }
  it { should validate_presence_of(:email) }
end

describe User, type: :model do
  it { is_expected.to have_many(:lists) }

  let!(:user) { create(:user) }

  describe '#favorited?' do
    let!(:list) { create(:list, public: true, name: 'List 2') }

    context 'ok' do
      before(:each) do
        user.add_favorite_list(list)
      end

      it 'returns true' do
        expect(user.reload.favorited?(list)).to be_truthy
      end
    end

    context 'nok' do
      it 'returns false' do
        expect(user.reload.favorited?(list)).to be_falsey
      end
    end
  end

describe '#add_favorite_lists' do
    context 'ok' do
      let!(:lists) do
        [
            create(:list, public: true, name: 'List 1'),
            create(:list, public: true, name: 'List 2')
        ]
      end

      before(:each) do
        lists.each do |list|
          user.add_favorite_list(list)
        end
        user.save
      end

      it 'adds lists to favorite lists' do
        expect(user.reload.favorite_lists.map(&:list_name)).to eq ['List 1', 'List 2']
      end
    end

    context 'nok' do
      let!(:list) { create(:list, public: true, name: 'List 2') }
      before(:each) do
        2.times do
          user.add_favorite_list(list)
        end

        user.save
      end

      it 'can not add a list twice for a user' do
        expect(user.reload.favorite_lists.map(&:list_name)).to eq ['List 2']
      end
    end
  end

  describe '#remove_list_from_favorites' do
    let!(:list_name) { 'List 2' }
    let!(:list) { create(:list, public: true, name: list_name) }

    before(:each) do
      user.add_favorite_list(list)
      user.remove_favorite_list(list)
    end

    it 'removes given list from favorites' do
      expect(user.reload.favorite_lists.map(&:list_name)).not_to include(list_name)
    end
  end
end
