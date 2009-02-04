module Sandstone
  module Controllers
    module PageTemplates
      def index
        @page_title = 'Templates'
        @page_templates = PageTemplate.find(:all, :conditions => {
          :subsite_id => current_subsite.id,
          :subsite_type => current_subsite.class.to_s
        })
      end

      def new
        @page_title = 'Create a Template'
        @page_template = PageTemplate.new
        @page_template.subsite = current_subsite
      end

      def edit
        @page_title = 'Edit a Template'
        @page_template = PageTemplate.find(params[:id], :conditions => {
          :subsite_id => current_subsite.id,
          :subsite_type => current_subsite.class.to_s
        })
      end

      def create
        @page_template = PageTemplate.new(params[:page_template])
        @page_template.subsite = current_subsite

        if @page_template.save
          Audit.log('create', editor, @page_template)
          flash[:notice] = 'Template was successfully created.'
          redirect_to page_templates_path
        else
          render :action => "new" 
        end
      end

      def update
        @page_template = PageTemplate.find(params[:id], :conditions => {
          :subsite_id => current_subsite.id,
          :subsite_type => current_subsite.class.to_s
        })


        if @page_template.update_attributes(params[:page_template])
          Audit.log('update', editor, @page_template)
          flash[:notice] = 'Template was successfully updated.'
          redirect_to page_templates_path
        else
          render :action => "edit" 
        end
      end

      def destroy
        @page_template = PageTemplate.find(params[:id], :conditions => {
          :subsite_id => current_subsite.id,
          :subsite_type => current_subsite.class.to_s
        })

        Audit.log('destroy', editor, nil, "#{@page_template.name} destroyed")
        @page_template.destroy

        redirect_to(page_templates_url) 
      end
    end
  end
end
