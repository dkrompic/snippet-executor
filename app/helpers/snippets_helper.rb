require 'Open3'

module SnippetsHelper

  # Executes 'command' and returns :json (default), :hash or :text format
  def execute_command(command, format=:json)
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
      output = {'output' => {'stdout' => stdout_lines, 'stderr' => stderr_lines}}
      case format
        when :text
          "#{stdout_lines.join('')}#{stderr_lines.join('')}"
        when :hash
           output
        else
           JSON.generate(output)
        end
    rescue StandardError => e
      "Error #{e.message} occured!"
      nil
    ensure
      stdin.close unless stdin.nil?
      stdout.close unless stdin.nil?
      stderr.close unless stdin.nil?
    end
  end
  
end
