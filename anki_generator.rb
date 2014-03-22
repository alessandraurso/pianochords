require_relative "latex_piano_chord_writer"
require_relative "anki_chord_writer"
require_relative "chord"
require 'logger'

# TODO:
# - Write pianochord_generator to be used from the command line
#   cf. http://rubylearning.com/blog/2011/01/03/how-do-i-make-a-command-line-tool-in-ruby/
#
# Improve test coverage:
# - test variants of generate invocations, with or without default
#   arguments (mock out the latex generation to save time during execution)
# - check the output of the anki_import_file (newlines correct?)

class AnkiGenerator


  def initialize(pngdirectory = "png", ankifile = "ankichords.txt", loglevel = Logger::WARN, logtarget = STDERR)
    @log = Logger.new(logtarget)
    @log.level = loglevel

    if !File.exists?(pngdirectory)
      @log.debug "Creating directory #{pngdirectory} to hold PNG files ..."
      Dir.mkdir(pngdirectory)
    elsif File.exists?(pngdirectory) && !File.directory?(pngdirectory)
      raise ArgumentError.new("Directory #{pngdirectory} cannot be created, a file exists instead in its place.")
    else
      @log.debug "Using existing directory #{pngdirectory} to hold PNG files ..."
    end

    if File.exists?(ankifile)
      raise ArgumentError.new("File #{ankifile} exists already, aborting.")
    end

    @ankifile = ankifile
    @pngdirectory = pngdirectory
  end

  # Expects a filename in which to store the anki deck information.
  def generate(file, root_notes = Note.note_symbols, chordtypes = Chord.chord_types, inversions = Chord.inversions)
    File::open(@ankifile, "w") do |f|
      originaldir = Dir.pwd
      Dir.chdir(@pngdirectory)
      root_notes.each do |root|
        chordtypes.each do |chordtype|
          inversions.each do |inversion|
            c = Chord.new(root,chordtype,inversion)
            a = AnkiChordWriter.new(c)
            @log.info "Generating Anki question for #{c.to_symbol}"
            LaTeXPianoChordWriter.new(c).generate_png(a.filename)
            f.puts a.importfile_line
          end
        end
      end
      Dir.chdir(originaldir)
    end
  end
end