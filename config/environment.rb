# frozen_string_literal: true

require 'roda'
require 'econfig'
require 'delegate'

module THSRParking
  # Configuration for the App
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    use Rack::Session::Cookie, secret: config.SESSION_SECRET # Session

    configure :development, :test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"

      secret_config = YAML.safe_load(File.read('./config/secrets.yml'))
      ENV['API_KEY'] = secret_config['API_KEY']

      ENV['PTX_APP_ID'] = secret_config['PTX_APP_ID']
      ENV['PTX_APP_KEY'] = secret_config['PTX_APP_KEY']
    end

    configure :production do
      # Set DATABASE_URL environment variable on production platform
    end

    configure do
      require 'sequel'
      DB = Sequel.connect(ENV['DATABASE_URL']) # rubocop:disable Lint/ConstantDefinitionInBlock

      def self.DB # rubocop:disable Naming/MethodName
        DB
      end
    end
  end
end
