require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe 'Class Methods' do
    it '.average_age' do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
      sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")

      expect(Astronaut.average_age).to eq(38.33)
    end
  end

  describe 'Instance Methods' do
    it '.alpha_missions' do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
      sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")

      capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 300)
      apollo = Mission.create!(title: "Apollo 13", time_in_space: 400)
      pisces = Mission.create!(title: "Pisces 12", time_in_space: 200)

      neil.missions << apollo
      buzz.missions << apollo
      neil.missions << capricorn
      sally.missions << capricorn
      sally.missions << pisces
      buzz.missions << pisces
      neil.missions << pisces

      expect(neil.alpha_missions).to eq([apollo, capricorn, pisces])
      expect(buzz.alpha_missions).to eq([apollo, pisces])
      expect(sally.alpha_missions).to eq([capricorn, pisces])
    end

    it '.total_time' do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
      sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")

      capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 300)
      apollo = Mission.create!(title: "Apollo 13", time_in_space: 400)
      pisces = Mission.create!(title: "Pisces 12", time_in_space: 200)

      neil.missions << apollo
      buzz.missions << apollo
      neil.missions << capricorn
      sally.missions << capricorn
      sally.missions << pisces
      buzz.missions << pisces
      neil.missions << pisces

      expect(neil.total_time).to eq(900)
      expect(buzz.total_time).to eq(600)
      expect(sally.total_time).to eq(500)
    end
  end
end
