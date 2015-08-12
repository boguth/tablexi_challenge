# Bo Guthrie's Solution to the Table XI Coding Challenge

## Live server: https://secret-waters-4458.herokuapp.com/

Thanks for visiting. I initially tested my solution in a much simpler form, which you can view [here](https://github.com/boguth/table_xi_tech_spike).

After getting it working, I decided to implement my solution as a rails app and deploy it to Heroku. I did this because I thought that in terms of usability, clicking a link and uploading a file is much easier than going through the process of cloning a github repo and running the application from the command line.

This challenge was fun for me. It was my first experience with an [NP-Complete](https://en.wikipedia.org/wiki/NP-complete) problem. At first, I attempted the primary algorithm without looking at any resources online, but after banging my head against the wall I started to wonder if there was a better way to go about it. I found the following two links very helpful in solving the problem:

- https://www.youtube.com/watch?v=NdF1QDTRkck
- http://stackoverflow.com/questions/4632322/finding-all-possible-combinations-of-numbers-to-reach-a-given-sum

In the interest of giving you a working solution in a reasonable timespan, I chose not to address a couple of things that would improve the functionality of the program. I wanted to list them below so that you know that I am aware of them.

1. As I started playing around with validating files and making sure that my solution works for only the formats that resemble the initial example, I stumbled on an edge case. If two different items cost the same the program adds both of them to a solution, thereby exceeding the specified target price. I have a pretty good idea about how to solve this. It would involve checking to see if two different items of the same price are on the list. If they are, the program would deliver two versions of the list. One list has one item, the other list has the other. Again, with more time I think I could easily solve this.

2. I know that right now there are a couple of algorithms in my application that are (O(n^2)). Being only recently exposed to Big O notation, I am still in the process of learning how to make my algorithms more lean, and I felt that the time it would take me to figure out how to get things down from quadratic time would surpass what was a reasonable amount of time to get you a working solution.

Things to know for folks looking through the code:
The code has a number of comments throughout. They should help guide anyone reading it through the control flow and logic. Please don't hesitate to get in touch with me with any questions.
