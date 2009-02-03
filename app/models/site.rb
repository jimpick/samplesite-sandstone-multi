class Site < ActiveRecord::Base
  has_many :page_templates, :as => :subsite
  has_many :pages, :as => :subsite
end
