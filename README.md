# Pangolynne.com

## Where to edit content on general pages

In most cases, you can edit directly and just match the format/style to the existing content.

/index.html
  Appears at pangolynne.com
  The 9 latest posts are shown here. They will automatically update.

/_pages/contact.html
  Appears at pangolynne.com/contact
  To add new FAQ items, copy an existing one to get all the styles.

## Adding a new event

You need to do 2 things to add a new event with photos!

1. Create a folder for the event photos in /assets/images/[event folder]
   Name the folder as `YYYY-MM-DD-event-name` with no spaces or special characters.
   Add all of the photos to this folder. ~700px or so will render well. They will
   render in alphabetical order, so to control the order, just rename them.

2. Create a post for event in /_posts/
   Name the file `YYYY-MM-DD-event-name.md` with no spaces or special characters.
   Configure the frontmatter (the content at the top) as below:

   ```
   ---
   layout: post
   title: "[title of the event]"
   location: [location of the event (or delete this line)]
   categories: [Any category you want]
   tags: [list of tags, separated by spaces]

   image: [The image you want to use as the cover image]
   gallery: /assets/images/[the folder with the photos]/
   ---
   ```

Once you have added all your event information, you need to commit the changes and then push them up to Github. After a few minutes the post will appear on your website!
