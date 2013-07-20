require 'bundler/setup'
require 'dotenv'
require 'google_drive'

Dotenv.load

username = ENV['GOOGLE_DRIVE_USERNAME']
password = ENV['GOOGLE_DRIVE_PASSWORD']
session = GoogleDrive.login(username, password)

spreadsheet = session.spreadsheet_by_key("0AlJXYhX0JFYkdDlDMzhoa0FweWM4ZzJITFdRdWd6Wnc")
worksheet = spreadsheet.worksheets[0]

populations = 47.times.map {|i|
  {
    prefecture: worksheet[20 + i, 10],
    population: {
      male:   worksheet[20 + i, 14].to_i,
      female: worksheet[20 + i, 15].to_i,
    }
  }
}

max_record = populations.max_by { |record|
  (record[:population][:male] - record[:population][:female]).abs
}

puts max_record[:prefecture]
