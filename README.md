Lab 6: Views and Controllers
===

Objectives
---

- help students understand how controllers work
- help students learn to work with views
- help students integrate Materialize CSS into projects

<hr />

# Part 1

1. For this project we are using another version of the BookManager application we've developed previously. To get a copy of this new project, use git to clone the [BookManager_3 project on github](https://github.com/67272-App-Design-Dev/lab6-bookmanager-starter) and review the contents before proceeding. Do not use your own lab 3 for your starter code as the models are slightly different. 

2. Run `bundle install` from the terminal to install the new gems used in this project. Then run `rails generate validates_timeliness:install` to install the updated `validates_timeliness` gem.

    **Commit these changes to git.**

3. Run `git branch` to see that you are on the master branch. **Checkout to a new branch named `views_controllers`**. Run the `rails db:migrate` command to generate the development database. **Start the server and verify that the basic app is running by looking at the various book routes.** (There are no controllers yet for authors and categories, so limit yourself to books for now.)

4. The first thing to do is to build a controller for `authors`. Open the `authors_controller.rb` file inside of `app/controllers` and within the class definition, add the following code to restrict the types of parameters we will accept from users.

    ```ruby
    private
    def author_params
      params.require(:author).permit(:first_name, :last_name, :active)
    end
    ```

    Note we make this a private method so that it can only be called by other methods within the class.

5. When we work with `show`, `edit`, `update` and `destroy` actions, we will be working with a particular author based on an `author_id` provided by the user via our interface. We want to create this author and assign it to an `@author` object before starting each of these methods. Put the following code at the top of (but still inside) the class definition:

    ```ruby
    before_action :set_author, only: [:show, :edit, :update, :destroy]
    ```

    This will run the `set_author` method prior to each of the `show`, `edit`, `update` and `destroy` actions. Now create this private method below the `author_params` method we created earlier with this code:

    ```ruby
    def set_author
      @author = Author.find(params[:id])
    end
    ```

6. Now we will create our standard RESTful actions in the controller: `index`, `show`, `new`, `edit`, `create`, `update` and `destroy`. We begin with `index`. Create the `index` method and **add the following code to get all of the active authors in alphabetical order and assign it to `@authors`**. Note we are also using the `will_paginate` gem to prepare the returned data for pagination:

    ```ruby
    @authors = Author.active.alphabetical.paginate(page: params[:page]).per_page(10)
    ```

    **Put the index action and all the other standard controller actions above the private methods we created earlier.** Everything after the key word 'private' will be a private method and REST actions should be public.

7. To create actions for `show` and `edit`, we just need the basic `def ... end` structure in place for each method. The controller will build the `@author` object for us using the `before_action` call from before. For the new method, we need a blank `@author` object for the user to populate with data and **we can do so by adding the following code to the controller class**:

    ```ruby
    def new
      @author = Author.new
    end
    ```


8. In our `create` and `update` actions, we will use our `author_params` method created earlier to make sure the parameters being sent are allowable. If we can create (or update) the `@author` object, then we will go to the author's show page and flash a quick message saying the changes where made; otherwise we will go back to the original form and show error messages. **Add this code to the controller class**:

    ```ruby
    def create
        @author = Author.new(author_params)
        if @author.save
            redirect_to author_path(@author), notice: "#{@author.name} was added to the system."
        else
            render action: 'new'
        end
    end

    def update
        if @author.update(author_params)
            redirect_to author_path(@author), notice: "#{@author.name} was revised in the system."
        else
            render action: 'edit'
        end
    end
    ```

9. For the `destroy` action we want to simply destroy the `@author` object and then return to the overall authors list (index). **Add this code to the controller class to do so**:

    ```ruby
    def destroy
        @author.destroy
        redirect_to authors_url
    end
    ```

10. Our authors controller is good, but without routes to direct to these actions, they are pretty useless. We could generate the seven routes manually or take advantage of Rails built-in shortcut that was demonstrated in class. Go to the `config/routes.rb` file and add `resources :authors` right below similar code for books -- this will generate the seven standard routes we need to use this controller properly. Restart your server and you should be able to use the authors controller!

11. Verify that the routes and controller are working in the browser and then commit your changes to git if you have not done so already. (Hopefully you have...) **Follow a similar procedure to build your categories controller**. You will need to add a resources line to your routes file for categories, and create the same set of methods in the categories controller.

# <span class="mega-icon mega-icon-issue-opened"></span>Stop

* * *

# Part 2

1.  As you can see, with essentially no CSS, the app functions appropriately, but does not look particularly attractive and seems unprofessional. We are going to use [materialize](https://github.com/mkhairi/materialize-sass) - to help us fix this up. Begin by going into your gemfile and adding:

    ```ruby
    gem 'sassc-rails'
    gem 'materialize-sass'
    ```

    Now run `bundle install` to install the new materialize gem in this project.

2. Before we see any changes we need to update our files. Create a new file in `app/assets/stylesheets` called `application.scss`, add the line `@import "materialize";`, and save the file. **We also need to delete the old `application.css` file** that was there so that the old css file does not override our new materialize css. Now we can **restart the server** and note the changes in formatting.

3. The font should look different, yet there are still many improvements to be made. The materialize framework provides a bunch of custom components that you can import and modify for your own application. They offer tons of documentation on [their website](http://materializecss.com/). The materialize default components are listed [here](http://materialize.labs.my/components).

4. Let's update our javascripts to work with materialize. **Go to `app/assets/javascripts/application.js` and replace the existing requirements with the following**:

    ```javascript
    //= require jquery
    //= require rails-ujs
    //= require materialize-sprockets
    //= require_tree .
    ```

5. We want to use Materialize's grid system to organize the application layout file to have three sections: a main content section, a small spacer, and a side bar with some quick links for navigation ease. **Replace the `<body>` section in the application layout (`app/views/layouts/application.html.erb`) with the following**:
    ```erb
    <body>
      <div class="row">
        <div class="col s8 center">
          <!-- MAIN CONTENT GOES HERE -->
          <%= yield %>
        </div>
        
        <div class="col s1">

        </div>
        
        <div class="col s3">
          <!-- SIDEBAR CONTENT GOES HERE -->
          <%= render partial: 'partials/quick_links' %>
        </div>
      </div>

      <footer>
        <div class="row">
          <div class="col s8 center">
            <%= render partial: 'partials/footer' %>
          </div>
        </div> 
      </footer>
    </body>
      ```

    Some partials have been provided already in the starter code, but you can edit them as appropriate. Note that the quick_links partial uses materialize's card formatting. Since we are adding these links on the side, **go into the `books` views and remove the links at the bottom of the `index`, `contracted`, and `proposed` view files**. 

6. We need to add a navigation bar to top of the page. There is great [documentation](http://materializecss.com/navbar.html) for this task if you want to customize further. For now, just inside the body tag of the application layout, **add the following code**:

    ```erb
      <!-- Dropdown Structure -->
      <ul id="authors-dropdown" class="dropdown-content">
        <li><%= link_to "List Authors", authors_path %></li>
        <li><%= link_to "Add an Author", new_author_path %></li>
      </ul>

      <nav>
        <div class="nav-wrapper">
          &nbsp&nbsp
          <a href="/" class="brand-logo">BookManager</a>
          <ul class="right">
            <!-- you can add a categories dropdown here if you built this controller -->
            <li><a class="dropdown-trigger" href="/authors" data-target="authors-dropdown">Authors<span class="material-icons">arrow_drop_down</span></a></li>
          </ul>
        </div>
      </nav>
    ```

    In `application.scss` **add this line at the end of the file** to access materialize icons:
    ```scss
    @import "https://fonts.googleapis.com/icon?family=Material+Icons";
    ```

    At the bottom of your `application.js` file **add this javascript code to make sure the dropdown in the navbar works**:

    ```javascript
    $(document).ready(function () {
        $(".dropdown-trigger").dropdown();
    })
    ```

    View in the browser to see these changes. **Now add a similar dropdown to view the Books!** Be sure to commit your files if you haven't already.

    Go ahead and implement a dropdown for that controller too.

    Let's try to change the color scheme ourselves. The materialize colors can be reset by adding: `$primary-color: #FFC107;` above `@import materialize` in the `application.scss` file. For your phase you may want to check out [Material Palette](https://www.materialpalette.com) to select your favorite colors and download color schemes for your app.

7. We want to turn the edit and destroy links in the `books#index` view into buttons. To do this, **add to the edit link**: `class: "waves-effect waves-light btn light-blue"` **and to the destroy link**: `class: "waves-effect waves-light btn red"`. View these changes in the browser. We want to change the size of the buttons so we review the [documentation](https://materializecss.com/buttons.html) again and open the `application.scss` file. Add `$button-height: 26px;` beneath the color settings, but still above the `@import materialize` line. Reload the page and view the changes to see that is what you want. Feel free to adjust other options with Materialize as you wish.

8. Lastly, we will edit the table in `books#index` a bit by first adding `class="striped"` to the table tag. Then we can adjust the color in our `application.scss` file by adding `$table-striped-color: #cfd8dc;` to the top of the file:

Make other customizations to tables as you wish -- see [http://materializecss.com/table.html](http://materializecss.com/table.html) for more information on options here. As time allows, make similar changes to the other books views.

# <span class="mega-icon mega-icon-issue-opened"></span>Stop


* * *

# Part 3

1. First to have nice form fields for Materialize we need to change the class from **`field`** to **`input-field`**. Here is an example:
 
    ```erb
    <h2>Book details:</h2>
    <div class="field">
      <%= f.label :title %><br />
      <%= f.text_field :title %>
    </div>
    ```

    Should become:

    ```erb
    <h2>Book details:</h2>
    <div class="input-field">
      <%= f.label :title %><br />
      <%= f.text_field :title %>
    </div>
    ```

    **Go into the books form and change the `div` field classes from `field` to `input-field`.**

2. Next, you'll notice that selecting categories is not working properly. This is because we haven't added any materialize javascript for the selector tool. In your `application.js` file add: `$("select").formSelect();` inside the `document.ready` block and check to make sure your dropdown box is working.

3. Continuing to build the form, we need to update how dates are input. Replace the old proposal_date form code with the following:

    ```erb
    <div class="input-field">
      <%= f.label :proposal_date %><br />
      <%= f.text_field :proposal_date, prompt: "Proposal Date", class: "datepicker", :value => (f.object.proposal_date.strftime('%B %d, %Y') if f.object.proposal_date != nil)%>
    </div>
    ```

    Note that we update the value that appears in the text field to avoid poorly formatted geek dates. Additionally, we need to add the following javascript inside the `document.ready` block to allow the user to have nice date selection option:

    ```javascript
    $(".datepicker").datepicker({
        format: "mmmm dd, yyyy",
        yearRange: 15
    });
    ```

    Follow a similar procedure for the addtional date fields in the rails form and check to make sure they are working correctly in your form.

4. To make sure that `units_sold` field is formatted correctly to accept a numerical input change the field from `text_field` to `number_field` with the following:

    ```erb
    <div class="input-field">
        <%= f.label :units_sold %><br />
        <%= f.number_field :units_sold %>
    </div>
    ```

5. Also, update the `notes` field to dynamically accept multiple lines of text by making it into an input-field and text area:

    ```erb
    <div class="input-field">
      <%= f.label :notes %><br /><br />
      <%= f.text_area :notes, :class=>"materialize-textarea"%>
    </div>
    ```

6. Now we need to have a nice list of authors who are connected with the book. **Remove the old authors partial tag and add the following code inside of the form** after the notes input-field and before the submit button:

    ```erb
    <h5>Add author(s):</h5>
    <% count = 0%>
    <div class="row">
      <% for author in Author.active.alphabetical  %>
        <% if count % 4 == 0%>
          </div>
          <div class="row">
        <% end %>
        <% count += 1 %>
        <div class="col s3">
          <label>
            <%= f.check_box :author_ids, {:multiple => true, :id=>author.id}, author.id, nil %>
            <span><%= author.name %></span>
          </label>
        </div>
      <% end %>
    </div>
    ```

    Note how we formatted the Authors in columns so that the form is more readable. The logic here is a little tricky so ask a TA if you have questions.

7.  The form is nearly complete, but we still need to update the actual submit button. Replace the old submit button with the following code:

    ```erb
    <div class="actions">
      <%= f.submit :class=>"btn waves-effect waves-light" %>
      <%= link_to 'Cancel', books_path, class: 'waves-effect waves-light btn red' %>
    </div>
    ```

    Reload the page to see these changes in effect. Use the form to create a new book in the system.

8.  One thing you might have noticed after using the form is that the usual flash message confirming our result did not appear. To correct that, go back the the application layout and add the following code in the main content section after the javascript_include_tag at the end:

    ```erb
    <% flash.each do |message_type, message| %>
      <%= javascript_tag "M.toast({html: '<p>#{message}</p>', displayLength: 4000})" %>
    <% end %>
    ```

    Also add this to `application.scss` so that the notification appears in an appropriate location on the screen:
    ```scss
    #toast-container {
        left:1%;
        right: auto !important;
    }
    ```
    If time allows, attempt to get the other forms in order. The documentation [here](http://materializecss.com/) is really excellent and can help you explore other options you might need. Merge all these commits back to master and get the TA to sign your sheet after reviewing the results and your git log.

    There is obviously so much more to Materialize, but this is a good introduction to using it in a dynamic Rails project that could prove helpful as you start working on Phase 3\. Please note that you will have to customize Materialize if you choose to use it in Phase 3 so that it has a distinctive look (expect a small grade penalty for a straight deploy of the Materialize CSS), but this is relatively easy to do as we saw at the beginning.

# <span class="mega-icon mega-icon-issue-opened"></span>Stop

* * * 