#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra/base'
require 'json'

require 'forgetful'
require "forgetful/extensions/csv/reminder_file"
require "forgetful/questionaire"

FILENAMES = []

#-------------------------------------------------

class ForgetfulApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public, File.join(File.dirname(__FILE__), '../public')

  def filenames2json(filenames)
    filenames = Array(filenames)

    data = filenames.map do |filename|
      questions = questionaire_from(filename).questions.sort_by { rand }
      {filename: filename, questions: questions}
    end
    data = data.select { |quiz| quiz[:questions].any? }

    JSON.generate(data)
  end

  def questionaire_from(filename)
    csv_file = ReminderFile.new(filename)
    Questionaire.new(csv_file)
  end

  get "/" do
    send_file File.join(options.public, 'index.html')
  end

  post "/quizzes" do
    filename  = params[:filename]
    results   = JSON.parse(params[:results]).map { |id,q| [id.to_i, q.to_i] }
    questionaire_from(filename).grade(results)

    filenames2json(filename)
  end

  get "/quizzes.json" do
    filenames2json(FILENAMES)
  end
end

