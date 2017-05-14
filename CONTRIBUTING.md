# Contributing Guidelines

Some basic conventions for contributing to this project.

### General

Please make sure that there aren't existing pull requests attempting to address
the issue mentioned. Likewise, please check for issues related to update, as
someone else may be working on the issue in a branch or fork.

* Non-trivial changes should be discussed in an issue first
* Develop in a topic branch, not master
* Squash your commits

### Commit Message Format

Each commit message should include a **type**, a **scope** and a **subject**:

```
 <type>(<scope>): <subject>
```

Lines should not exceed 100 characters. This allows the message to be easier to
read on github as well as in various git tools and produces a nice, neat commit
log ie:

```
 #271 feat(standard): add style config and refactor to match
 #270 fix(config): only override publicPath when served by webpack 
 #269 feat(eslint-config-defaults): replace eslint-config-airbnb 
 #268 feat(config): allow user to configure webpack stats output 
```

#### Type

Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **doc**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space,
  formatting, missing semi-colons, etc)
* **refactor**: A code change that neither fixes a bug or adds a feature
* **test**: Adding missing tests
* **chore**: Changes to the build process or auxiliary tools and libraries such
  as documentation generation

#### Scope

The scope could be anything specifying place of the commit change. For example
`document`, `label`, etc...

#### Subject

The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end

### How-to add new content?

With the upstream repository:

* Create new issue describing the article subject. Name of the issue should
  respect the following format: "Article: [Title]".
* Create branch from this issue. The branch name should follow this format:
  `<n>-article-<title>` with `n` as the issue number and `title` as
  hyphen-delimited title.
* Fetch new created branch:

```
git fetch upstream
git co -b <n>-article-<title> upstream/<n>-article-<title>
```

* Create the new article:

```
hugo new blog/x-xxx.md
```

* Check that this article is in draft mode: `draft = true`
* Run hugo as server in draft mode: `hugo server -p 3000 -D `
* Once the article completed un-draft the document:

```
hugo undraft blog/x-xxx.md
# or manualy: 'draft = true' and update the date (with VIM: `:r! date -R`)
```

* Commit this this kind of message: *"doc(): add xxx article"*
* Push your modification to the upstream:

```
git push upstream
```

* Create merge request and proceed to code review loops
* Once the article merged into the master branch, fetch this master branch and
  push it to the public repository:

```
git co dev
git fetch upstream
git merge upstream/master
git push origin dev
```
* Deploy new content to self hosted website:

```
make deploy
```

* Done!

