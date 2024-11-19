# frozen_string_literal: true

project1 = Project.create!(
  name: 'Projeto 1',
  start_date: Date.new(Date.today.year, 1, 1),
  end_date: Date.new(Date.today.year, 12, 31)
)

project1.activities.create!(
  [
    {
      name: 'Atividade 1 - Finalizada',
      start_date: Date.new(Date.today.year, 6, 1),
      end_date: Date.new(Date.today.year, 7, 1),
      finished: true
    },
    {
      name: 'Atividade 2 - Não finalizada',
      start_date: Date.new(Date.today.year, 8, 1),
      end_date: Date.new(Date.today.year, 12, 31),
      finished: false
    }
  ]
)

project2 = Project.create!(
  name: 'Projeto 2',
  start_date: Date.new(Date.today.year, 6, 1),
  end_date: Date.new(Date.today.year, 6, 30)
)

project2.activities.create!(
  [
    {
      name: 'Atividade 1 - Não finalizada',
      start_date: Date.new(Date.today.year, 6, 1),
      end_date: Date.new(Date.today.year, 6, 15),
      finished: false
    },
    {
      name: 'Atividade 2 - Não finalizada',
      start_date: Date.new(Date.today.year, 6, 16),
      end_date: Date.new(Date.today.year, 6, 26),
      finished: false
    },
    {
      name: 'Atividade 3 - Não finalizada',
      start_date: Date.new(Date.today.year, 6, 27),
      end_date: Date.new(Date.today.year, 7, 5),
      finished: false
    }
  ]
)

puts 'Woohoo!'
