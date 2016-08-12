require 'rails_helper'

describe Task, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:list_id)}
end

describe Task, type: :model  do
  it { is_expected.to belong_to(:list) }

  context 'creating a record without name' do
    let!(:task) {Task.new(name: '')}
    it 'returns false' do
      expect(task.save).to be_falsy
    end
  end

  describe '#done?' do
    context 'when a task is done' do
      let!(:task) {Task.new(name: 'Task', done: 1)}

      it 'returns true' do
        expect(task.done?).to be_truthy
      end
    end

    context 'when a task is not done' do
      let!(:task) {Task.new(name: 'Task', done: 0)}
      it 'returns false' do
        expect(task.done?).to be_falsy
      end
    end
  end
end