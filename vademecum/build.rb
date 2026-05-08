#!/usr/bin/env ruby
require "yaml"
require "optparse"
require "shellwords"

ROOT = File.expand_path(File.dirname(__FILE__))
MANIFEST = YAML.load_file(File.join(ROOT, "manifest.yaml"))

def chapters
  MANIFEST.fetch("chapters")
end

def chapter_paths
  chapters.map { |c| File.join(ROOT, c.fetch("file")) }
end

def ensure_chapters!
  miss = chapter_paths.reject { |p| File.file?(p) }
  raise "missing chapters: #{miss.join(", ")}" unless miss.empty?
end

def run_cmd(cmd)
  ok = system(cmd)
  raise "failed: #{cmd}" unless ok
end

def target_pandoc(argv)
  opts = {"dot"=>nil, "format"=>"pdf", "out"=>MANIFEST.dig("targets","pandoc","defaults","out") || "dslutils-man.pdf"}
  OptionParser.new do |o|
    o.on("--dot=PATH"){|v| opts["dot"]=v}
    o.on("--format=FMT"){|v| opts["format"]=v}
    o.on("--out=FILE"){|v| opts["out"]=v}
  end.parse!(argv)
  ensure_chapters!
  tmp = File.join(ROOT, ".concat.md")
  File.open(tmp, "w") do |f|
    f.puts "# #{MANIFEST.fetch("title")}"
    chapters.each do |c|
      f.puts "
\newpage
"
      f.puts File.read(File.join(ROOT, c.fetch("file")))
    end
  end
  cmd = ["pandoc", tmp, "-o", opts["out"]]
  if opts["dot"]
    cmd += ["--metadata", "dot=#{opts["dot"]}"]
  end
  run_cmd(cmd.shelljoin)
end

def target_manpages(argv)
  opts = {"out_dir"=>File.expand_path(MANIFEST.dig("targets","manpages","defaults","out_dir") || "./man"), "suffix"=>MANIFEST.dig("targets","manpages","defaults","suffix") || "3dsl", "post_hook"=>nil}
  OptionParser.new do |o|
    o.on("--out-dir=DIR"){|v| opts["out_dir"]=File.expand_path(v)}
    o.on("--suffix=S"){|v| opts["suffix"]=v}
    o.on("--post-hook=CMD"){|v| opts["post_hook"]=v}
  end.parse!(argv)
  ensure_chapters!
  Dir.mkdir(opts["out_dir"]) unless Dir.exist?(opts["out_dir"])
  chapters.each_with_index do |c, i|
    src = File.join(ROOT, c.fetch("file"))
    out = File.join(opts["out_dir"], format("dslutils-%02d.%s", i + 1, opts["suffix"]))
    run_cmd(["pandoc", "-s", "-t", "man", src, "-o", out].shelljoin)
  end
  run_cmd(opts["post_hook"]) if opts["post_hook"]
end

def target_custom(argv)
  script = nil
  args = ""
  OptionParser.new do |o|
    o.on("--script=PATH"){|v| script=v}
    o.on("--args=STR"){|v| args=v}
  end.parse!(argv)
  raise "--script is required" unless script
  ensure_chapters!
  files = chapter_paths.map { |p| Shellwords.escape(p) }.join(" ")
  run_cmd("#{Shellwords.escape(script)} #{args} #{files}")
end

def target_check(_argv)
  ensure_chapters!
  chapter_paths.each do |p|
    raise "empty chapter: #{p}" if File.read(p).strip.empty?
  end
  puts "check: ok"
end

target = ARGV.shift
raise "usage: ruby vademecum/build.rb <pandoc|manpages|custom|check> [options]" unless target

case target
when "pandoc" then target_pandoc(ARGV)
when "manpages" then target_manpages(ARGV)
when "custom" then target_custom(ARGV)
when "check" then target_check(ARGV)
else raise "unknown target: #{target}"
end
