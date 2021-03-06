# encoding: UTF-8

require 'gooddata/cli/cli'

describe GoodData::CLI do
  describe 'role' do
    it 'Complains when no parameters specified' do
      args = %w(role)

      out = run_cli(args)
      out.should include "Command 'role' requires a subcommand list"
    end

    describe 'role list' do
      it 'Complains when no project ID specified' do
        args = %w(role list)

        out = run_cli(args)
        out.should include 'Project ID has to be provided'
      end

      it 'List roles when passing project ID' do
        pending 'Investignate which project to use'

        args = [
          '-p',
          ProjectHelper::PROJECT_ID,
          'role',
          'list',
        ]

        out = run_cli(args)

        expected_roles = [
          'adminRole,/gdc/projects/tk6192gsnav58crp6o1ahsmtuniq8khb/roles/2'
        ]

        expected_roles.each do |expected_role|
          out.should include expected_role
        end
      end
    end
  end
end