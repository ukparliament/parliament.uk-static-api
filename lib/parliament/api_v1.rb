require 'sinatra'
require 'sinatra/namespace'

module Parliament
  class APIv1 < Sinatra::Base
    ID_REGEX = /\w{8}/

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
            namespace '/members' do
              get '/a_z_letters' do
                @party_id = id_param(params[:party_id])

                path = request.path_info.gsub!(@party_id, 'ID')

                respond(path)
              end

              get '/:letter' do
                @party_id = id_param(params[:party_id])

                path = request.path_info.gsub!(@party_id, 'ID')

                empty_letters = ['x', 'y']

                @letter = params[:letter]

                letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

                path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

                respond(path)
              end

              namespace '/current' do
                get '/a_z_letters' do
                  @party_id = id_param(params[:party_id])

                  path = request.path_info.gsub!(@party_id, 'ID')

                  respond(path)
                end

                get '/:letter' do
                  @party_id = id_param(params[:party_id])

                  path = request.path_info.gsub!(@party_id, 'ID')

                  empty_letters = ['x', 'y']

                  @letter = params[:letter]

                  letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

                  path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

                  respond(path)
                end
              end
            end

            get '/*' do
              @party_id = id_param(params[:party_id])

              path = request.path_info.gsub!(@party_id, 'ID')

              respond(path)
            end
          end
        end
      end
    end

    namespace '/people' do
      get '/a_z_letters' do
        respond(request.path_info)
      end

      # get either an ID or a letter parameter for the people/:id path 
      # Sinatra assumes we are passing in a letter so we manually check what the parameter
      get '/:id_or_letter' do
        if params[:id_or_letter].match ID_REGEX
          @person_id = id_param(params[:id_or_letter])

          path = request.path_info.gsub!(@person_id, 'ID')

          respond(path)
        else
          empty_letters = ['x', 'y']

          @letter = params[:id_or_letter]

          letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

          path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

          respond(path)
        end
      end

      namespace '/:person_id' do
        get '/*' do
          @person_id = id_param(params[:person_id])

          path = request.path_info.gsub!(@person_id, 'ID')

          respond(path)
        end

        namespace '/constituencies' do
          namespace '/current' do
          end
        end
      end

      namespace '/members' do
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
    end

    namespace '/parties' do
      get '/a_z_letters' do
        respond(request.path_info)
      end

      get '/:id_or_letter' do
        if params[:id_or_letter].match ID_REGEX
          @party_id = id_param(params[:id_or_letter])

          path = request.path_info.gsub!(@party_id, 'ID')

          respond(path)
        else
          empty_letters = ['x', 'y']

          @letter = params[:id_or_letter]

          letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

          path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

          respond(path)
        end
      end

      namespace '/:party_id' do
        namespace '/members' do

          get '/a_z_letters' do
            @party_id = id_param(params[:party_id])

            path = request.path_info.gsub!(@party_id, 'ID')

            respond(path)
          end

          get '/:letter' do
            @party_id = id_param(params[:party_id])

            path = request.path_info.gsub!(@party_id, 'ID')

            empty_letters = ['x', 'y']

            @letter = params[:letter]

            letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

            path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

            respond(path)
          end

          get do
            @party_id = id_param(params[:party_id])

            path = request.path_info.gsub!(@party_id, 'ID')

            respond(path)
          end

          namespace '/current' do
            get '/a_z_letters' do
              @party_id = id_param(params[:party_id])

              path = request.path_info.gsub!(@party_id, 'ID')

              respond(path)
            end

            get '/:letter' do
              @party_id = id_param(params[:party_id])

              path = request.path_info.gsub!(@party_id, 'ID')

              empty_letters = ['x', 'y']

              @letter = params[:letter]

              letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

              path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

              respond(path)
            end
          end
        end
      end
    end

    namespace '/constituencies' do
      namespace '/postcode_lookup' do
        namespace '/:postcode' do
          get do
            @postcode = params[:postcode]

            path = request.path_info.gsub!(%r{#{@postcode}}, 'ID')

            respond(path)
          end
        end
      end

      get '/a_z_letters' do
        respond(request.path_info)
      end

      get '/:id_or_letter' do
        if params[:id_or_letter].match ID_REGEX
          @constituency_id = id_param(params[:id_or_letter])

          path = request.path_info.gsub!(@constituency_id, 'ID')

          respond(path)
        else
          empty_letters = ['x', 'y']

          @letter = params[:id_or_letter]

          letter_file = empty_letters.include?(@letter) ? 'EMPTY_LETTER' : 'LETTER'

          path = request.path_info.gsub!(%r{#{@letter}\Z}, letter_file)

          respond(path)
        end
      end

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

      namespace '/lookup' do
      end

      namespace '/:constituency_id' do
        get '/*' do
          @constituency_id = id_param(params[:constituency_id])

          path = request.path_info.gsub!(@constituency_id, 'ID')

          respond(path)
        end

        namespace '/contact-point' do
        end

        namespace '/map' do
        end

        namespace '/members' do
          namespace '/current' do
          end
        end
      end
    end

    namespace '/contact_points' do
      namespace '/:contact_point_id' do
        get do
          @contact_point_id = id_param(params[:contact_point_id])

          path = request.path_info.gsub!(@contact_point_id, 'ID')

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
      send_file(path, type: 'application/n-triples', disposition: 'inline')
    end

    def id_param(param)
      return not_found unless param.match? ID_REGEX

      param
    end
  end
end
