require 'rails_helper'

describe List, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
end

describe List, type: :model do
  it { is_expected.to have_many(:tasks) }

  context 'list done' do
    let!(:list) { create(:list, name: 'List Name') }
    let!(:task) { create(:task, name: 'Task Name', list_id: list.id, done: true) }

    it 'return List Name is done' do
      expect(List.find(list.id).done).to be_truthy
    end
  end

  context 'creating a record without name' do
    let!(:list) { List.new(name: '') }

    it 'returns false' do
      expect(list.save).to be_falsy
    end
  end

  describe '#created_by?' do
    context 'when a list is created by a given user' do
      let!(:list) { create(:list) }
      let!(:user) { create(:user, lists: [list]) }

      it 'returns true' do
        expect(list.created_by?(user)).to be_truthy
      end
    end

    context 'when a list is not created by a given user' do
      let!(:list) { create(:list) }
      let!(:user) { create(:user, id: 2) }

      it 'returns false' do
        expect(list.created_by?(user)).to be_falsy
      end
    end
  end

  describe '#public' do
    let!(:list) { create(:list, name: "List 222") }

    context 'add_mark_public' do
      before(:each) do
        List.new.add_mark_public(list)
      end

      it { expect(List.find(list.id).public).to be_truthy }
    end

    context 'remove_mark_public' do
      before(:each) do
        List.new.remove_mark_public(list)
      end

      it { expect(List.find(list.id).public).to be_falsy }
    end
  end
end