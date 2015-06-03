require 'Open3'
require 'rest-client'
require 'base64'

module SnippetsHelper

  # In 'production' or 'development' environment command is executed aginst REST service, whilst in 'test' environment it is executed locally
  def execute_snippet_content(command)
    if ['production', 'development'].include?(Rails.env.to_s)
      begin
        credentials = Rails.configuration.custom[Rails.env]['command_execute']['auth']
        url = Rails.configuration.custom[Rails.env]['command_execute']['url']

        auth = 'Basic ' + Base64.encode64(credentials).chomp
        response = RestClient.get url, {params: {command: command}, Authorization: auth}
        
        JSON.parse(response, symbolize_names: true) 
      rescue StandardError => e
        logger.error "Snippet execution failed with message: #{e.message}"
        {success: false, stdout: [], stderr: ["#{e.message}\n"]}
      end
    else
      begin
        stdin, stdout, stderr = Open3.popen3(command)
        
        stdout_lines = []
        while line = stdout.gets do
          stdout_lines += [line]
        end
        stderr_lines = []
        while line = stderr.gets do
          stderr_lines += [line]
        end
        
        {success: true, stdout: stdout_lines, stderr: stderr_lines}
      rescue Errno::ENOENT => e
        {success: true, stdout: [], stderr: ["#{e.message}\n"]}
      rescue StandardError => e
        {success: false, stdout: [], stderr: ["#{e.message}\n"]}
      ensure
        stdin.close unless stdin.nil?
        stdout.close unless stdin.nil?
        stderr.close unless stdin.nil?
      end
    end
  end
 
end
