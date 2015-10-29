To run the tests (TestDriver) you should populate a test repository with BOTH
ontology/MSEE_base.owl and ontology/TA_BIVOLINO.owl, then uncomment the method
calls that you want to run. Tests can be run in any order, and if they complete
successfully they leave the ontology unchanged; if any error occurs (blocking
exceptions or simply a failed test message appearing in the console), you
should reset the repository before proceeding with more tests.

When using this project as a library to manage ontologies inside your app, you
can look at TestDriver as an example. 

If you are not running tests, you can load whatever ontology you want in your
repository, provided the MSEE_base.owl one is always loaded as well. You might
even experiment with multiple ontologies in the same repository, but remember
that you'll need a separate RepositoryDAO instance for each namespace you have.
 