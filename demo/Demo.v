From Coq Require Extraction.
From CheckedExtract Require Import Loader.

Axiom test: unit.
CheckedExtract test => "5".

Axiom test2: unit.
Extract Constant test2 => "test".

Axiom test3: unit.
CheckedExtract test3 => "test".

Extraction "test.ml" test test2 test3.
