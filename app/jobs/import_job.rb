class ImportJob < ApplicationJob
  def perform(csv_path)
    ImportDataFromCsv.process(csv_path)
  end
end