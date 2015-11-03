class FileAnalysisJob < ActiveJob::Base
  queue_as :default

  def perform(file_path, file_analysis)
    puts "iniciando job ..."
    file_analysis.update(status: :processing)

    csv = CSV.read(file_path)
    csv.each do |row|
      sleep 5 # simulate heavy processing
      file_analysis.update(analyzed_rows: file_analysis.analyzed_rows + 1)
    end
    file_analysis.update(status: :finished)
  end
end
