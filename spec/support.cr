# Taken from https://github.com/crystal-lang/crystal/blob/b2b4a8bdc7df81d2a37985b3cc0aefce0a1f336b/spec/support/fibers.cr

def wait_until_blocked(f : Fiber, timeout = 5.seconds)
  now = Time.monotonic

  until f.resumable?
    Fiber.yield
    raise "fiber failed to block within #{timeout}" if (Time.monotonic - now) > timeout
  end
end

def wait_until_finished(f : Fiber, timeout = 5.seconds)
  now = Time.monotonic
  until f.dead?
    Fiber.yield
    raise "fiber failed to finish within #{timeout}" if (Time.monotonic - now) > timeout
  end
end

# Taken from https://github.com/crystal-lang/crystal/blob/b2b4a8bdc7df81d2a37985b3cc0aefce0a1f336b/spec/std/http/spec_helper.cr

private def wait_for(timeout = 5.seconds)
  now = Time.monotonic

  until yield
    Fiber.yield

    if (Time.monotonic - now) > timeout
      raise "server failed to start within #{timeout}"
    end
  end
end

# Helper method which runs *server*
# 1. Spawns `server.listen` in a new fiber.
# 2. Waits until `server.listening?`.
# 3. Yields to the given block.
# 4. Ensures the server is closed.
# 5. After returning from the block, it waits for the server to gracefully
#    shut down before continuing execution in the current fiber.
# 6. If the listening fiber raises an exception, it is rescued and re-raised
#    in the current fiber.
def run_server(server)
  server_done = Channel(Exception?).new

  f = spawn do
    server.listen
  rescue exc
    server_done.send exc
  else
    server_done.send nil
  end

  begin
    wait_for { server.listening? }
    wait_until_blocked f

    yield server_done
  ensure
    server.close unless server.closed?

    if exc = server_done.receive
      raise exc
    end
  end
end
