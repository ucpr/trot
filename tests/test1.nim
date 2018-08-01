import terminal
import unittest

test "isTrueColorSupported":
  enableTrueColors()
  assert(isTrueColorSupported())
