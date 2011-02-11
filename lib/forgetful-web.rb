#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra/base'
require 'json'
require 'forgetful'

FILENAMES = []

#-------------------------------------------------

class ForgetfulApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public, File.join(File.dirname(__FILE__), '../public')

  def filenames2json(filenames)
    filenames = Array(filenames)

    data = filenames.map do |filename|
      questions = Reminder.read_csv(filename).
                           map.with_index { |reminder, i| [reminder, i] }.
                           select { |reminder, i| reminder.due_on <= Date.today }.
                           map do |reminder,i|
                             { id:       i,
                               question: reminder.question,
                               answer:   reminder.answer }
                           end.
                           sort_by { rand }

      {filename: filename, questions: questions}
    end
    data = data.select { |quiz| quiz[:questions].any? }

    JSON.generate(data)
  end

  get "/" do
    send_file File.join(options.public, 'index.html')
  end

  post "/quizzes" do
    filename  = params[:filename]
    results   = JSON.parse(params[:results])
    reminders = Reminder.read_csv(filename)

    results.each do |id,q|
      id = id.to_i
      reminders[id] = reminders[id].next(q)
    end

    Reminder.write_csv(filename, reminders.sort)

    filenames2json(filename)
  end

  get "/quizzes.json" do
    filenames2json(FILENAMES)
  end
end

