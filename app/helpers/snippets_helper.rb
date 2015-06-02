require 'Open3'

module SnippetsHelper

  # Executes recieves 'command' and 'cmd_output_format' parameters, and returns hash with status and command execution output.
  # Result hash format is {success: <true|false>, stdout: [<stdout ouput>], stderr: [<stderr output>]}
  # Reported status can be true or false
  # Result example: {success: true, stdout: ["hello!\n"], stderr:[]}
  def execute_command(command)
    execute_command_locally(command)
  end
  
  def execute_command_remotelly(command)
  end
  
  def execute_command_locally(command)
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
