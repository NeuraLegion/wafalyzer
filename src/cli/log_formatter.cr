module Wafalyzer::CLI
  LogFormatter = ::Log::Formatter.new do |entry, io|
    colors = settings.colors

    severity = entry.severity
    io << severity.label.to_s.rjust(6).colorize(settings.severity_colors[severity])
    io << ' '

    source = entry.source.presence
    if source
      io << '(' << source.colorize(colors[:source]) << ')'
      io << ' '
    end

    timestamp = entry.timestamp
    io << '[' << timestamp.to_s.colorize(colors[:datetime]) << ']'

    message = entry.message
    io << " -- " << message

    data = entry.data
    unless data.empty?
      io << " -- " << data.to_s.colorize(colors[:metadata])
    end

    context = entry.context
    unless context.empty?
      io << " -- " << context.to_s.colorize(colors[:metadata])
    end

    ex = entry.exception
    if ex
      io.puts
      ex.inspect_with_backtrace(io)
    end
  end
end
