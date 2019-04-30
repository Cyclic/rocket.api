module NL
  class AppV2 < Grape::API
    version 'v2', using: :path

    desc 'User\'s Resources Management', {headers: {'X-Nl-Auth-Token' => {required: true}}}
    before {authenticate!}

    mount ::NL::V2::Core::Reproduce

  end
end
