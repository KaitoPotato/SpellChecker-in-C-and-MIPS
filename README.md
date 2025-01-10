[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/8XJQmeY5)
![BuildAndTest](../../workflows/BuildAndTest/badge.svg?branch=main) ![Points badge](../../blob/badges/.github/badges/points.svg)

# Inf2C-CS 2024/25 | Coursework 1

**Deadline:** October 25, 2024 at 16:00 BST
**Instructors:** Boris Grot (Course Organiser), Jianyi Cheng, Björn Franke

**TAs:** Kim Stonehouse, Dilina Dehigama, Shengda Zhu, Shyam Jesalpura

The objective of this coursework is to get you familiar with programming in MIPS. There are tasks which require you to write solutions in the provided skeleton files. For each task, we have provided some associated tests, which you can use to check your solutions.

Each test case is worth points, and you can obtain these points by correctly passing the test case. Your points balance is shown at the top of the README, and will update every time you push changes to GitHub.

Please note that your point balance is **NOT** your final grade. After the deadline, your code will be subject to further hidden testing, so it is important that you also write your own tests, to ensure that your code is thoroughly tested.

## 1. Downloading the coursework

To get started, you will need to **clone** this repository. If you have used GitHub before, you will already have a HTTPS access token or an SSH key. If you do not have either, you will need to create one of them following the guides below:
  - To create an SSH key, use [this guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
  - To create a HTTPS token, use [this guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). Feel free to tick all the boxes when asked what permissions you would like to grant this token.

At this point, you can clone the repository:
  - If you used HTTPS above, use the command:
    ```
    git clone https://github.com/inf2c-cs-2022/REPOSITORY_NAME.git
    ```
  - If you used SSH, use the command:
    ```
    git clone git@github.com:inf2c-cs-2022/REPOSITORY_NAME.git
    ```
Once the clone has finished, you can enter the repository directory:
```
cd REPOSITORY_NAME
```
If this is your first time using Git, you will need to do a bit of configuration:
  ```
  git config --global user.name "your_github_username"
  git config --global user.email "your_github_email"
  ```
This will set your username and email globally, so all future GitHub repositories will inherit this configuration (unless they overwrite it). If you do not wish to do that, just omit the `--global`. You can verify the setup using `git config -l`, which will tell you what you just set.

## 2. Writing your solutions

Each task has its own folder inside `src` folder containing the template files. Please write your solution for each task in the skeleton file specified in the task description. Since the tasks build on one another, you are encouraged to reuse functions from previous tasks.

**For detailed task descriptions, please refer to Handout.pdf.**

## 3. Pushing your changes to GitHub

You are encouraged to commit your work regularly. This allows you to track the history of your changes and revert to an earlier version of your code, if you need to. It also protects you from losing any of your work in the case of a computer failure. Furthermore, every time you commit and push your changes, your points on the README are updated, giving you continuous feedback on your implementation.
As mentioned above, your point balance is **NOT** your final grade.

To find out which tests fail you can access the test log using the following steps:
Once, you have pushed your changes the test will automatically start running. Once completed you will see a green tick or a red cross next to your commit hash. Click on the tick or cross then _details_ on the opening callout.
![GitHub Actions](img.md/step12.png)

You will find the test log by expanding the *Run education/autograding@v1* section.
![GitHub Actions](img.md/step3.png)
Correct test are marked with a green tick and incorrect tests with a red cross.
You can find the inputs and outputs of the tests in `.github/classroom/autograding.json`. You can use this to debug your code.


## 4. Testing your solutions locally

Throughout this coursework, you will be asked to write C programs and MIPS programs. In addition to the GitHub tests, you should run your own tests. To test your programs locally, you can use the provided `Makefile` in each task directory.

For task1 and task2, you will be required to write a MIPS program. For the last task, you will be also be asked to write a C program.
We encourage you to write the solution in C first, then translate it into MIPS. This will help you to better understand the algorithm on a higher level before you implement it in MIPS.

To avoid cross-system compatibility issues, you must make sure that your code runs on DICE. We strongly suggest you develop it on DICE as well to avoid last-minute surprises. You can also use Virtual DICE, a version of DICE Linux that runs in VirtualBox, for your work if you want to. You can find more information on Virtual DICE here – https://blog.inf.ed.ac.uk/systems/2024/09/25/new-virtual-dice-for-2024-25/ and https://computing.help.inf.ed.ac.uk/vdice. Please note that we will be using DICE machines for grading purposes. CODE THAT DOES NOT RUN ON DICE WILL RECEIVE A MARK OF 0 REGARDLESS OF HOW WELL IT RUNS ON YOUR SYSTEM.

## 5. Submitting your code

Once you have pushed all of your changes to GitHub and you are happy with your code and your points, you are finished! At the deadline, we will revoke your write access to this repository and grade your work. The last version committed before the deadline is the one that will be marked. 

## 6. Good scholarly practice

Please remember the good scholarly practice requirements of the University regarding work for credit. You can find guidance on the School page:

https://web.inf.ed.ac.uk/infweb/admin/policies/academic-misconduct

This also has links to the relevant University pages.

As mentioned, your code will be subject to further automatic and manual review after the deadline. Submitted code will be checked for similarity with other submissions using the [MOSS system](http://theory.stanford.edu/~aiken/moss/). MOSS has been effective at finding similarities in the past and it is not fooled by name changes or reordering of code blocks. Courseworks are **individual**, and we expect everyone to submit their sole, independent work.

Extensions or Extra Time Adjustments (ETA) are permitted up to a maximum of six days, but cannot be combined. If assessed coursework is submitted late without an approved extension or ETA, a penalty of 5% per calendar day will be applied, up to a maximum of six days after the original deadline, after which a mark of zero will be given.

## 7. Asking questions

If you have questions about MIPS, you should consult the lecture slides, lab materials and the appendix of the Patterson and Hennessy course textbook. If you have questions about the coursework, please start by **checking existing discussions** on Piazza. You should only start a new discussion if you cannot find the answer in the existing posts. It is quite possible that other students will already have encountered and solved the same problem and will be able to help you. The TA will also monitor Piazza and clarify things as necessary, after allowing time for student discussion to take place. Please be reminded that academic misconduct regulations also apply to Piazza, so you should **not** post coursework solutions or code snippets publicly. If in doubt, make your question private, and an instructor will check if the post is acceptable.
