Aurora 4 scripts
================

The basic sequence is this:

0.  You need an `iss-wsj` working version!  All the language models
and the like are the same.  Ideally it should be `../iss-wsj`

1. Then, run this sequence of scripts to set up the infrastructure:
```
CreateLinks.sh   # Creates links to the database and to iss-wsj
CreateLists.sh   # Creates the file lists in ./local
```

2. Now models can be trained.  Replace my-dir with whatever you like.
```
ExtractTrain.sh my-dir  # Extract features for training
TrainGMM.sh my-dir      # Train Gaussian mixture HMMs using HTS
```

3. Test the models.  Check the scripts to determine which tests.
```
ExtractTest.sh my-dir   # Extract all 14 test types
TestGMM.sh my-dir       # Run all 14 tests
Score.sh my-dir         # Score all 14 tests
```

[Phil Garner](http://www.idiap.ch/~pgarner), April 2012
...but based on work from a couple of years earlier
