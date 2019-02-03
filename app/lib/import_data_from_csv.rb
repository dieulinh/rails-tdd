require 'csv'
class ImportDataFromCsv
  class << self
    def process(path)
      CSV.foreach(path, encoding: 'ISO8859-1', headers: true, col_sep: ';') do  |row|
        intercommunality = Intercommunality.find_or_create_by(siren: row['siren_epci']) do |record|
          record.name = row['nom_complet']
          record.form = map_intercommunality_form[row['form_epci']]
        end

        intercommunality.communes.find_or_create_by(
            code_insee: row['insee'],
            name:       row['nom_com'],
            population: row['pop_total']
        )
      end
    end

    def map_intercommunality_form
      {
          'CC' => 'cc',
          'METRO' => 'met',
          'CA' =>'ca'
      }
    end
  end
end