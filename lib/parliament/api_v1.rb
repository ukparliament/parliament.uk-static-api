require 'sinatra'
require 'sinatra/namespace'

module Parliament
  class APIv1 < Sinatra::Base
    register Sinatra::Namespace

    configure do
      enable :logging
      enable :raise_errors if ENV['AIRBRAKE_API_KEY'] && ENV['AIRBRAKE_PROJECT_ID']
    end

    set :public_folder, Proc.new { File.join(root, 'data') }

    get '/' do
      'Welcome to the static Parliament API'
    end

    namespace '/houses' do
      namespace '/:house_id' do
        namespace '/members' do
          namespace '/current' do
            get '/a_z_letters' do
              respond(request.path_info)
            end

            get '/:letter' do
              empty_letters = ['x', 'y']

              @letter = params[:letter]

              letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

              path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

              respond(path)
            end
          end
        end

        namespace '/parties' do
          namespace '/:party_id' do
            get '/*' do
              # @house_id = id_param(params[:house_id])
              @party_id = id_param(params[:party_id])

              path = request.path_info.gsub!(@party_id, 'ID')

              respond(path)
            end
          end
        end
      end
    end

    namespace '/people' do
      namespace '/members' do
        namespace '/current' do
          get '/a_z_letters' do
            respond(request.path_info)
          end

          get '/:letter' do
            empty_letters = []

            @letter = params[:letter]

            letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

            path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

            respond(path)
          end
        end
      end

      namespace '/:person_id' do
        get do
          @person_id = id_param(params[:person_id])

          path = request.path_info.gsub!(@person_id, 'ID')

          respond(path)
        end
      end
    end

    get '/*' do
      respond(request.path_info)
    end

    private

    def respond(path)
      file_path = File.join(settings.public_folder, 'api', 'v1', path)
      file_exists = File.file?(file_path)

      if file_exists
        ntriple_response(file_path)
      else
        index_file_path = File.join(file_path, 'index')

        File.file?(index_file_path) ? ntriple_response(index_file_path) : not_found
      end
    end

    def ntriple_response(path)
      send_file(path, type: 'application/n-tiples', disposition: 'inline')
    end

    def id_param(param)
      return not_found unless param.match? /\w{8}/

      param
    end
  end
end
