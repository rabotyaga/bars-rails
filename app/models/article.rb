class Article < ActiveRecord::Base
  default_scope { where("nr is not null") }
  default_scope { order(:nr) }

  belongs_to :first_letter
  has_many :logs

  belongs_to :root_article, class_name: "Article", foreign_key: "root_id"
  has_many   :sub_articles, class_name: "Article", foreign_key: "root_id"

  before_save do |a|
    a.ar_inf_wo_vowels = Article.remove_vowels(a.ar_inf)
    a.ar_inf_wo_vowels_n_hamza = Article.remove_hamza(a.ar_inf_wo_vowels)
  end

  after_create do |a|
    if Article.where(:nr => a.nr).count > 1
      Article.where(["nr >= ? AND id <> ?", a.nr, a.id]).update_all("nr = nr + 1")
    end
  end

  before_save do |a|
    if !a.is_root && !a.root_id
      ra = Article.unscoped.where(["nr < ? AND is_root = TRUE", a.nr]).order("nr DESC").first
      a.root_id = ra.id
    elsif a.is_root && a.root_id
      a.root_id = nil
    end
  end

  def source_link
    str = ""
    str += (source.blank? ? "" : "#{I18n.t(:source)}#{source}")
    #if !str.blank? && page
    #  str += ", "
    #end
    #str += (page ? "#{I18n.t(:page)}#{page}"  : "")
    #str
  end

  def root
    root = ""
    if is_root
      root = ar_inf_wo_vowels
    else
      root = root_article.try(:ar_inf_wo_vowels)
    end
    root.sub!(/^\((.+)\)$/, '\1')
    if root.blank?
      root = "???"
    end
    root
  end

  def root_id
    if is_root
      return id
    else
      super
    end
  end

  def formatted_translation
    if translation
      tr = translation.gsub(/(\s)+/,'\1')
      # remove double or even more spaces
      #tr.gsub!(/(\s)+/,'\1')
      # remove spaces before , . ; )
      tr.gsub!(/(\S)\s([,\.;\)])/,'\1\2')
      # remove spaces after (
      tr.gsub!(/([\(])\s(\S)/, '\1\2')
      # insert \n before \d+) or \d+.
      tr.gsub!(/\s(\d+[\)\.])/, "\n" + '\1')
      # remove \n's between \d+) or \d+.
      tr.gsub!(/(\d[\.\)])\n(\d[\.\)])/, '\1 \2')
      # add space after \d)
      tr.gsub!(/(\d+\))(\S)/, '\1 \2')
      # remove \n after \d\) if it is in the end of line
      tr.gsub!(/\n(\d+\)$)/, ' \1')
    else
      tr = translation
    end
    return tr
  end

  def opts
    opts = ""
    if !opt.empty?
      opts = bidiWrap(opt,true) + " "
    end
    if !mn1.empty?
      opts += bidiWrap(mn1,true) + " "
    end
    if !ar1.empty?
      opts += bidiWrap(ar1,false) + " "
    end
    if !mn2.empty?
      opts += bidiWrap(mn2,true) + " "
    end
    if !ar2.empty?
      opts += bidiWrap(ar2,false) + " "
    end
    if !mn3.empty?
      opts += bidiWrap(mn3,true) + " "
    end
    if !ar3.empty?
      opts += bidiWrap(ar3,false) + " "
    end
    opts.gsub!(/\s+$/, '')
  end

  def bidiWrap(string, ltr)
    if ltr
      "\u202A" + string + "\u202C"
    else
      "\u202B" + string + "\u202C"
    end
  end

  def self.import(file)
    header = ["nr", "ar_inf", "form", "opt", "mn1", "ar1", "mn2", "ar2", "mn3", "ar3", "translation", "notes"]
    lines = IO.readlines(file.path)
    new_lines = []
    lines.each do |line|
      if line =~ /\A\d+\t/
        new_lines.push(line.chomp)
      else
        new_lines.last.concat(line.chomp)
      end
    end
    new_lines.each do |line|
      attrs = line.split(/\t/)
      attrs.each do |a|
        a.strip!
        a.delete!("\"")
        a.gsub!(/(;)\s*(\d+\))/,"\\1\n\\2")
      end
      while attrs.size < 12 do
        attrs.push("")
      end
      while attrs.size > 12 do
        attrs.pop
      end
      row = Hash[[header, attrs].transpose]
      article = Article.where(:nr => row["nr"]).first || Article.new
      article.update(row)
      article.save!
    end
  end

  def self.fill_in_vocalization
    Article.all.each do |a|
      if a.opt =~ /^\(([ауи\/, \(\)]+)(или)*([ауи\/, \(\)]*)\)$/
        logger.debug "match " + a.opt + " nr: " + a.nr.to_s
        a.vocalization = a.opt
        a.opt = ""
        a.save!
      end
    end
  end

  def self.fill_in_homonym_nr
    Article.all.each do |a|
      if a.opt =~ /^\d+$/
        logger.debug "match " + a.opt + " nr: " + a.nr.to_s
        a.homonym_nr = a.opt.to_i
        a.opt = ""
        a.save!
      end
    end
  end

  def self.fill_in_homonym_nr_from_mn1
    Article.all.each do |a|
      if a.mn1 =~ /^\d+$/
        logger.debug "match " + a.mn1 + " nr: " + a.nr.to_s
        a.homonym_nr = a.mn1.to_i
        a.mn1 = ""
        a.save!
      end
    end
  end

  def self.fill_in_ar_inf_wo_vowels_n_hamza
    Article.all.each do |a|
      a.ar_inf_wo_vowels_n_hamza = Article.remove_hamza(a.ar_inf_wo_vowels)
      a.save
    end
  end

  def self.remove_vowels(string)
    string.gsub(/[\u064b\u064c\u064d\u064e\u064f\u0650\u0651\u0652\u0653\u0670]/,'')
  end

  def self.remove_hamza(string)
    string.gsub(/[\u0622\u0623\u0625]/,"\u0627").gsub(/\u0624/,"\u0648").gsub(/\u0626/,"\u0649")
  end

  def self.remove_vowels_n_hamza(string)
    self.remove_hamza(self.remove_vowels(string))
  end

  def self.show_dfc(string)
    string.gsub(/\u202a/, "<LRE>").gsub(/\u202b/, "<RLE>").gsub(/\u202c/, "<PDF>").gsub(/\u202d/, "<LRO>").gsub(/\u202e/, "<RLO>")
  end

  def self.hide_dfc(string)
    string.gsub(/<LRE>/, "\u202a").gsub(/<RLE>/, "\u202b").gsub(/<PDF>/, "\u202c").gsub(/<LRO>/, "\u202d").gsub(/<RLO>/, "\u202e")
  end

  def translation_dfc
    Article.show_dfc(translation)
  end

  def translation_dfc=(string)
    self.translation=Article.hide_dfc(string)
  end

  def self.dump_dictionary_xml
    Article.where(:is_root => true).all.each do |ra|

      puts "<d:entry id=\"#{ra.id}\" d:title=\"#{ra.ar_inf}\">"

        puts "  <d:index d:value=\"#{ra.ar_inf}\" d:title=\"#{ra.ar_inf}\" d:anchor=\"xpointer(//*[@id='#{ra.id}'])\" />"

        if ra.ar_inf_wo_vowels_n_hamza != ra.ar_inf
          puts "  <d:index d:value=\"#{ra.ar_inf_wo_vowels_n_hamza}\" d:title=\"#{ra.ar_inf}\" d:anchor=\"xpointer(//*[@id='#{ra.id}'])\" />"
        end

        puts "  <div id=\"#{ra.id}\" class=\"article\">"

        puts "    <div class=\"root\"><h1>#{ra.root}</h1></div>"

        if ra.ar_inf !~ /^\(.*\)$/
          puts "    <div class=\"ar_inf\"><h2>#{ra.ar_inf}</h2></div>"
        end

        if !ra.transcription.nil? && !ra.transcription.empty?
          puts "    <div d:pr=\"1\" class=\"transcription\">#{ra.transcription}</div>"
        end

        if !ra.form.nil? && !ra.form.empty?
          puts "    <div class=\"form\">#{ra.form}</div>"
        end

        if !ra.vocalization.nil? && !ra.vocalization.empty?
          puts "    <div class=\"vocalization\">#{ra.vocalization}</div>"
        end

        if !ra.opts.nil? && !ra.opts.empty?
          puts "    <div class=\"opts\">#{ra.opts}</div>"
        end

        if !ra.homonym_nr.nil?
          puts "    <div class=\"homonym_nr\">#{ra.homonym_nr}</div>"
        end

        if !ra.translation.nil? && !ra.translation.empty?
          puts "    <div class=\"translation\">#{ra.translation}</div>"
        end

        puts "  </div>"
      ra.sub_articles.each do |a|

        puts "  <d:index d:value=\"#{a.ar_inf}\" d:title=\"#{a.ar_inf}\" d:anchor=\"xpointer(//*[@id='#{a.id}'])\" />"

        if a.ar_inf_wo_vowels_n_hamza != a.ar_inf
          puts "  <d:index d:value=\"#{a.ar_inf_wo_vowels_n_hamza}\" d:title=\"#{a.ar_inf}\" d:anchor=\"xpointer(//*[@id='#{a.id}'])\" />"
        end

        puts "  <div id=\"#{a.id}\" class=\"article\">"

        puts "    <div class=\"ar_inf\"><h2>#{a.ar_inf}</h2></div>"

        if !a.transcription.nil? && !a.transcription.empty?
          puts "    <div d:pr=\"1\" class=\"transcirption\">#{a.transcription}</div>"
        end

        if !a.form.nil? && !a.form.empty?
          puts "    <div class=\"form\">#{a.form}</div>"
        end

        if !a.vocalization.nil? && !a.vocalization.empty?
          puts "    `<div class=\"vocalization\">#{a.vocalization}</div>"
        end

        if !a.opts.nil? && !a.opts.empty?
          puts "    <div class=\"opts\">#{a.opts}</div>"
        end

        if !a.homonym_nr.nil?
          puts "    <div class=\"homonym_nr\">#{a.homonym_nr}</div>"
        end

        if !a.translation.nil? && !a.translation.empty?
          puts "    <div class=\"translation\">#{a.translation}</div>"
        end

        puts "  </div>"
      end
      puts "</d:entry>"
    end
  end

end
