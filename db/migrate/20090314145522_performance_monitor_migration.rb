class PerformanceMonitorMigration < ActiveRecord::Migration
  def self.up
    create_table :log_entries, :force => true do |t|
      t.string   "server_name"
      t.string   "server_address"
      t.string   "http_host"
      t.string   "remote_address"
      t.string   "app_name"
      t.string   "path"
      t.datetime "access_time"
      t.string   "controller"
      t.string   "action"
      t.integer  "size"
      t.integer  "status_code"
      t.decimal  "execution_time", :precision => 8, :scale => 4
    end

    create_table :hits, :force => true do |t|
      t.string  "app_name"
      t.string  "server"
      t.date    "date"
      t.integer "hour"
      t.integer "hits"
    end

    create_table :execution_times, :force => true do |t|
      t.string  "app_name"
      t.string  "server"
      t.date    "date"
      t.integer "hour"
      t.decimal "min", :precision => 8, :scale => 4
      t.decimal "max", :precision => 8, :scale => 4
      t.decimal "sum", :precision => 8, :scale => 4
      t.decimal "avg", :precision => 8, :scale => 4
      t.integer "count"
    end

    create_table :executor_entries, :force => true do |t|
      t.string    "name"
      t.string    "status"
      t.string    "message"
      t.datetime  "started"
      t.datetime  "finished"
      t.decimal   "duration", :precision => 8, :scale => 4
    end

  end

  def self.down
    drop_table :log_entries
    drop_table :hits
    drop_table :execution_times
    drop_table :executor_entries
  end
end