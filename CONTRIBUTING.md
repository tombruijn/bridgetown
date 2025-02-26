# Contributing

[fork]: https://github.com/bridgetownrb/bridgetown/fork
[pr]: https://github.com/bridgetownrb/bridgetown/compare
[style]: https://github.com/styleguide/ruby
[code-of-conduct]: CODE_OF_CONDUCT.md

Hi there! We're thrilled that you'd like to contribute to this project. Your help is essential for keeping it great.

Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [project's open source license](LICENSE).

Please note that this project is released with a [Contributor Code of Conduct][code-of-conduct]. By participating in this project you agree to abide by its terms.

## Submitting a pull request

0. [Fork][fork] and clone the repository
0. Configure and install the dependencies: `bundle`
0. Make sure the tests pass on your machine: `bundle exec rake`
0. Create a new branch: `git checkout -b my-branch-name`
0. Make your change, add tests, and make sure the tests still pass
0. Add an entry to the top of `CHANGELOG.md` for your changes
0. If it's your first time contributing, add yourself to the contributors at the bottom of `README.md`
0. Push to your fork and [submit a pull request][pr]
0. Pat your self on the back and wait for your pull request to be reviewed and merged.

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

- Write tests.
- Keep your change as focused as possible. If there are multiple changes you would like to make that are not dependent upon each other, consider submitting them as separate pull requests.
- Write a [good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## Releasing

If you are the current maintainer of this gem:

1. Bump gem version in `bridgetown-core/lib/bridgetown-core/version.rb`. Try to adhere to SemVer.
1. Add version heading/entries to `CHANGELOG.md`.
1. Make sure your local dependencies are up to date: `bundle`
1. Ensure that tests pass and build/release all monorepo gems: `bundle exec rake release_all`
1. Push latest main along with new release tag: `git push --follow-tags`
1. Create a GitHub release with the pushed tag (https://github.com/bridgetownrb/bridgetown/releases/new) and populate it with a list of the commits from `git log --pretty=format:"- %s" --reverse refs/tags/[OLD TAG]...refs/tags/[NEW TAG]`

## Attribution

Special thanks to the **ViewComponent project** for [providing the language comprising most of this document](https://github.com/bridgetownrb/bridgetown/blob/main/CONTRIBUTING.md).
