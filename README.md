<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. RESUME (Scheme)</a>
<ul>
<li><a href="#sec-1-1">1.1. General</a></li>
<li><a href="#sec-1-2">1.2. Experience</a>
<ul>
<li><a href="#sec-1-2-1">1.2.1. NB</a></li>
</ul>
</li>
<li><a href="#sec-1-3">1.3. SKILLS</a></li>
<li><a href="#sec-1-4">1.4. Education</a></li>
</ul>
</li>
<li><a href="#sec-2">2. RESUME (Features)</a></li>
<li><a href="#sec-3">3. Config</a>
<ul>
<li><a href="#sec-3-1">3.1. Gems</a></li>
<li><a href="#sec-3-2">3.2. Routes</a></li>
</ul>
</li>
<li><a href="#sec-4">4. MVC</a>
<ul>
<li><a href="#sec-4-1">4.1. Models</a>
<ul>
<li><a href="#sec-4-1-1">4.1.1. Resume Model</a></li>
<li><a href="#sec-4-1-2">4.1.2. Experience Model</a></li>
<li><a href="#sec-4-1-3">4.1.3. Program Model&#xa0;&#xa0;&#xa0;<span class="tag"><span class="Education">Education</span></span></a></li>
</ul>
</li>
<li><a href="#sec-4-2">4.2. Views</a>
<ul>
<li><a href="#sec-4-2-1">4.2.1. Resumes Views</a></li>
<li><a href="#sec-4-2-2">4.2.2. Experiences Views</a></li>
<li><a href="#sec-4-2-3">4.2.3. Programs Views</a></li>
</ul>
</li>
<li><a href="#sec-4-3">4.3. Controllers</a>
<ul>
<li><a href="#sec-4-3-1">4.3.1. Resumes Controller</a></li>
<li><a href="#sec-4-3-2">4.3.2. Experiences Controller</a></li>
<li><a href="#sec-4-3-3">4.3.3. Programs Controller</a></li>
</ul>
</li>
<li><a href="#sec-4-4">4.4. Classes</a>
<ul>
<li><a href="#sec-4-4-1">4.4.1. ResumePDF</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>

Model after <file:///home/son/IBT/jewelry/rails/CaseJewelryRails/README.md>, in particular, 
for pdf(Prawn) design and generation as a stylized presentation of data.

PURPOSE: Resume building guide that produces a pdf designed by custom prawn 
templates

# RESUME (Scheme)<a id="sec-1" name="sec-1"></a>

4.1.1

    rails g model Resume name:string

## General<a id="sec-1-1" name="sec-1-1"></a>

-   [ ] Resume name
    
        name:string

## Experience<a id="sec-1-2" name="sec-1-2"></a>

4.1.2

"Add an experience"

    rails g model Experience title:string begin_date:date end_date:date achievements:text

-   [ ] Title
-   [ ] Beginning Date
-   [ ] Ending Date
-   [ ] Achievements
    -   comma separated 
        -   to hash/array?

### NB<a id="sec-1-2-1" name="sec-1-2-1"></a>

with regards Date, Time, Datetime

<http://stackoverflow.com/questions/5941613/are-the-date-time-and-datetime-classes-necessary>

PROJECT FIRST APPROACH: *date*

## SKILLS<a id="sec-1-3" name="sec-1-3"></a>

"Add a skill"

    rails g migration AddSkillsToResume skills:text

-   [ ] skill:text
    -   comma separated values

## Education<a id="sec-1-4" name="sec-1-4"></a>

4.1.3

"Add a program"

    rails g model Program school:string course:string

-   [ ] School Name
-   [ ] Course/s

# RESUME (Features)<a id="sec-2" name="sec-2"></a>

# Config<a id="sec-3" name="sec-3"></a>

## Gems<a id="sec-3-1" name="sec-3-1"></a>

<./Gemfile>

    source 'https://rubygems.org'
    
    gem 'rails', '4.2.6'
    gem 'pg', '~> 0.15'
    gem 'sass-rails', '~> 5.0'
    gem 'uglifier', '>= 1.3.0'
    gem 'coffee-rails', '~> 4.1.0'
    gem 'jquery-rails'
    gem 'turbolinks'
    gem 'jbuilder', '~> 2.0'
    gem 'sdoc', '~> 0.4.0', group: :doc
    gem 'prawn'
    
    group :development, :test do
      gem 'byebug'
    end
    
    group :development do
      gem 'web-console', '~> 2.0'
    
      gem 'spring'
    end

## Routes<a id="sec-3-2" name="sec-3-2"></a>

<./config/routes.rb>

    Rails.application.routes.draw do
      #resources :labelsheets, :except => [:show]
      #resources :labelsheets, :only => [:show], :defaults => { :format => 'pdf' }
    
      resources: resumes 
      resources: experiences
      resources: programs
    
      get "/" => "resumes#show"
    
      #get "labelsheets" => "labelsheets#new"
      #get "labelsheets/:id", to: "labelsheets#show", defaults: { format: 'pdf' }
    
      #constraints format: 'pdf' do
      #  resources :labelsheets, only: [:show]
      #end
    
      #get 'dashboard/show'
    
    
    
      #get "/dashboard" => "dashboard#show"
    
      #get "/callback" => "auth0#callback"
      #get "/auth/auth0/callback" => "auth0#callback"
      #get "/auth/failure" => "auth0#failure"
    
    end

# MVC<a id="sec-4" name="sec-4"></a>

## Models<a id="sec-4-1" name="sec-4-1"></a>

### Resume Model<a id="sec-4-1-1" name="sec-4-1-1"></a>

    rails g model Resume name:string

<./app/models/resume.rb>

    class Resume < ActiveRecord::Base
      #dragonfly_accessor :logo
    
      has_many :experiences
      has_many :programs
      accepts_nested_attributes_for :experiences, :reject_if ==> :all_blank, :allow_destroy => true
    
    end

### Experience Model<a id="sec-4-1-2" name="sec-4-1-2"></a>

    rails g model Experience title:string begin_date:date end_date:date achievements:text

<./app/models/experience.rb>

    class Experience < ActiveRecord::Base
      belongs_to :resume
    end

### Program Model     :Education:<a id="sec-4-1-3" name="sec-4-1-3"></a>

    rails g model Program school:string course:string

<./app/models/program.rb>

    class Program < ActiveRecord::Base
      belongs_to :resume
    end

## Views<a id="sec-4-2" name="sec-4-2"></a>

### Resumes Views<a id="sec-4-2-1" name="sec-4-2-1"></a>

<./app/views/resumes/>

<./app/views/resumes/index.html.erb>

    <p id="notice"><%= notice %></p>
    
    <h1>Listing Resumes</h1>
    
    <table>
      <thead>
        <tr>
          <th>Index</th>
          <th colspan="3"></th>
        </tr>
      </thead>
    
      <tbody>
        <% @resumes.each do |resume| %>
          <tr>
            <td><%= link_to 'Show', resume %></td>
            <td><%= link_to 'Edit', edit_resume_path(resume) %></td>
            <td><%= link_to 'Destroy', resume, method: :delete, data: { confirm: 'Are you sure?' } %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    
    <br>
    
    <%= link_to 'New Resume', new_resume_path %>

<./app/views/resumes/show.html.erb>

    <p id="notice"><%= notice %></p>
    
    <p>
      <strong>Index:</strong>
      <%= @resume.file_name if @resume.file_stored? %>
      <%= link_to 'PDF', "#{@resume.id}.pdf" %>
    </p>
    
    <%= link_to 'Edit', edit_resume_path(@resume) %> |
    <%= link_to 'Back', resumes_path %>

<./app/views/resumes/new.html.erb>

    <%= render 'form' %>
    <br/>
    
    <%= link_to 'Resumes', resumes_path, class: 'pure-button pure-button-primary' %>

<./app/views/resumes/_form.html.erb>

    <%= form_for(@resume, :html => {:target => '_blank', :multipart => true}) do |f| %>
    <% if @resume.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@resume.errors.count, "error") %> prohibited this resume from being saved:</h2>
    
      <ul>
        <% @resume.errors.full_messages.each do |message| %>
        <li><%= message %></li>
        <% end %>
      </ul>
    </div>
    <% end %>
    
    <div class="field">
      <%= f.label "Name" %>
      <%= f.text_field %>
    </div>
    <br/>
    
    <h2>EXPERIENCE:</h2>
    
    <div class="form-group">
      <%= f.fields_for :experiences, @resume.experiences do | f_experience | %>
    
        <%= f_experience.label :title %>
        <%= f_experience.text_field :title %>
    
        <%= f_experience.label :begin_date %>
        <%= f_experience.date_select :begin_date %>
    
        <%= f_experience.label :end_date %>
        <%= f_experience.date_select :end_date %>
    
        <%= f_experience.label :achievements %>
        <%= f_experience.text_area :achievements %>
    
      <% end %>
    </div>
    
    <h2>SKILLS:</h2>
    
    <div class="field">
      <%= f.label :skills %>
      <%= f.text_area %>
    </div>
    
    <h2>EDUCATION:</h2>
    
    <div class="form-group">
      <%= f.fields_for :programs, @resume.programs do | f_program | %>
    
        <%= f_program.label :school %>
        <%= f_program.text_field :school %>
    
        <%= f_program.label :course %>
        <%= f_program.text_field :course %>
    
      <% end %>
    </div>
    
    
    <div class="actions">
      <%= f.submit 'Make Resume', class: 'pure-button pure-button-primary' %>
    </div>
    <% end %>

### Experiences Views<a id="sec-4-2-2" name="sec-4-2-2"></a>

### Programs Views<a id="sec-4-2-3" name="sec-4-2-3"></a>

## Controllers<a id="sec-4-3" name="sec-4-3"></a>

### Resumes Controller<a id="sec-4-3-1" name="sec-4-3-1"></a>

    rails g controller Resumes

<./app/controllers/resumes_controller.rb>

    class ResumesController < ApplicationController
      before_action :set_resume, only: [:show, :edit, :update, :destroy]
      #before_action :logged_in_using_omniauth?, only: [:new, :edit, :update, :destroy]
    
      def index
        @resumes = Resume.all
      end
    
      def show
        @resume = Resume.find(params[:id])
        respond_to do |format|
          format.html
          format.pdf do
            pdf = ResumePdf.new(@resume, view_context)
            send_data pdf.render,
                      filename: "resume_#{@resume.created_at.strftime("%d/%m/%Y")}.pdf",
                      type: "application/pdf",
                      disposition: "inline"
          end
        end
      end
    
      def new
        @resume = Resume.new
        @resume.experiences.new
        @resume.programs.new
      end
    
      def edit
      end
    
      def create
        @resume = Resume.new(resume_params)
    
        respond_to do |format|
          if @resume.save
            format.pdf { render :pdf => "show" }
            format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
            format.json { render :show, status: :created, location: @resume }
          else
            format.html { render :new }
            format.json { render json: @resume.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def update
        respond_to do |format|
          if @resume.update(resume_params)
            format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
            format.json { render :show, status: :ok, location: @resume }
          else
            format.html { render :edit }
            format.json { render json: @resume.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def destroy
        @resume.destroy
        respond_to do |format|
          format.html { redirect_to resumes_url, notice: 'Resume was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    
      private
      def set_resume
        @resume = Resume.find(params[:id])
      end
    
      def resume_params
        params.require(:resume).permit(:name, :experiences, :skills, :programs)
      end
    
    end

### Experiences Controller<a id="sec-4-3-2" name="sec-4-3-2"></a>

    rails g controller Experiences

<./app/controllers/experiences_controller.rb>

    class ExperiencesController < ApplicationController
      before_action :set_experience, only: [:show, :edit, :update, :destroy]
      #before_action :logged_in_using_omniauth?, only: [:new, :edit, :update, :destroy]
    
      def index
        @experiences = Experience.all
      end
    
      def show
        @experience = Experience.find(params[:id])
        respond_to do |format|
          format.html
          format.pdf do
            pdf = ExperiencePdf.new(@experience, view_context)
            send_data pdf.render,
                      filename: "experience_#{@experience.created_at.strftime("%d/%m/%Y")}.pdf",
                      type: "application/pdf",
                      disposition: "inline"
          end
        end
      end
    
      def new
        @experience = Experience.new
      end
    
      def edit
      end
    
      def create
        @experience = Experience.new(experience_params)
    
        respond_to do |format|
          if @experience.save
            format.pdf { render :pdf => "show" }
            format.html { redirect_to @experience, notice: 'Experience was successfully created.' }
            format.json { render :show, status: :created, location: @experience }
          else
            format.html { render :new }
            format.json { render json: @experience.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def update
        respond_to do |format|
          if @experience.update(experience_params)
            format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
            format.json { render :show, status: :ok, location: @experience }
          else
            format.html { render :edit }
            format.json { render json: @experience.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def destroy
        @experience.destroy
        respond_to do |format|
          format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    
      private
      def set_experience
        @experience = Experience.find(params[:id])
      end
    
      def experience_params
        params.require(:experience).permit(:title, :begin_date, :end_date, :achievements)
      end
    
    end

### Programs Controller<a id="sec-4-3-3" name="sec-4-3-3"></a>

    rails g controller Programs

<./app/controllers/programs_controller.rb>

    class ProgramsController < ApplicationController
      before_action :set_program, only: [:show, :edit, :update, :destroy]
      #before_action :logged_in_using_omniauth?, only: [:new, :edit, :update, :destroy]
    
      def index
        @programs = Program.all
      end
    
      def show
        @program = Program.find(params[:id])
        respond_to do |format|
          format.html
          format.pdf do
            pdf = ProgramPdf.new(@program, view_context)
            send_data pdf.render,
                      filename: "program_#{@program.created_at.strftime("%d/%m/%Y")}.pdf",
                      type: "application/pdf",
                      disposition: "inline"
          end
        end
      end
    
      def new
        @program = Program.new
      end
    
      def edit
      end
    
      def create
        @program = Program.new(program_params)
    
        respond_to do |format|
          if @program.save
            format.pdf { render :pdf => "show" }
            format.html { redirect_to @program, notice: 'Program was successfully created.' }
            format.json { render :show, status: :created, location: @program }
          else
            format.html { render :new }
            format.json { render json: @program.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def update
        respond_to do |format|
          if @program.update(program_params)
            format.html { redirect_to @program, notice: 'Program was successfully updated.' }
            format.json { render :show, status: :ok, location: @program }
          else
            format.html { render :edit }
            format.json { render json: @program.errors, status: :unprocessable_entity }
          end
        end
      end
    
      def destroy
        @program.destroy
        respond_to do |format|
          format.html { redirect_to programs_url, notice: 'Program was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    
      private
      def set_program
        @program = Program.find(params[:id])
      end
    
      def program_params
        params.require(:program).permit(:school, :course)
      end
    
    end

## Classes<a id="sec-4-4" name="sec-4-4"></a>

### ResumePDF<a id="sec-4-4-1" name="sec-4-4-1"></a>

<./app/pdfs/resume_pdf.rb>

    class ResumePdf < Prawn::Document
      def initialize(resume, view)
        super()
        @resume = resume
    
        @view = view
      end
    end
