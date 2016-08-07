module SapphireBot
  # The format log timestamps should be in, in strftime format
  LOG_TIMESTAMP_FORMAT = '%Y-%m-%d-%H:%M:%S'.freeze

  # Logs debug messages
  class Logger
    # Only here because discordrb crashes without it
    attr_writer :fancy
    # Creates a new logger.
    def initialize(mode = :normal)
      self.mode = mode
      time = Time.now.strftime(LOG_TIMESTAMP_FORMAT)

      if @enabled_modes.include?(:debug)
        @log_file = "#{Dir.pwd}/logs/#{time}-debug.log"
      else
        @log_file = "#{Dir.pwd}/logs/#{time}.log"
      end
    end

    # The modes this logger can have. This is probably useless unless you want to write your own Logger
    MODES = {
      debug: { long: 'DEBUG', short: 'D', format_code: '' },
      good: { long: 'GOOD', short: '✓', format_code: "\u001B[32m" }, # green
      info: { long: 'INFO', short: 'i', format_code: '' },
      warn: { long: 'WARN', short: '!', format_code: "\u001B[33m" }, # yellow
      error: { long: 'ERROR', short: '✗', format_code: "\u001B[31m" }, # red
      out: { long: 'OUT', short: '→', format_code: "\u001B[36m" }, # cyan
      in: { long: 'IN', short: '←', format_code: "\u001B[35m" } # purple
    }.freeze

    # The ANSI format code that resets formatting
    FORMAT_RESET = "\u001B[0m".freeze

    # The ANSI format code that makes something bold
    FORMAT_BOLD = "\u001B[1m".freeze

    MODES.each do |mode, hash|
      define_method(mode) do |message|
        time = Time.now.strftime(LOG_TIMESTAMP_FORMAT)
        if @enabled_modes.include? mode
          write(message, hash, time)
          write_to_file(message, hash, time) if @log_modes.include?(mode)
        end
      end
    end

    def mode=(value)
      case value
      when :debug
        @log_modes = @enabled_modes = [:debug, :good, :info, :warn, :error, :out, :in]
      when :normal
        @log_modes = [:warn, :error]
        @enabled_modes = [:info, :warn, :error]
      end
    end

    # Logs an exception to the console.
    def log_exception(e)
      error(e.inspect)
      e.backtrace.each { |line| error(line) }
    end

    private

    def write(message, mode, timestamp)
      puts "[#{mode[:format_code]}#{timestamp} #{mode[:long]}#{FORMAT_RESET}] #{message}"
    end

    def write_to_file(message, mode, timestamp)
      File.open(@log_file, 'a+') do |f|
        f.write("[#{timestamp} #{mode[:long]}] #{message}\n")
      end
    end
  end
end
