import Data.Maybe
import Text.Show.Functions

-- Return ID of source that is currently used
-- Source priority is following
-- (if there are equal ones, the one with highest ID is selected)
-- - Source with device.bus: bluetooth
-- - Source with device.class: monitor
-- - Source with device.form_factor: internal
-- - any
-- Only sources with [RUNNING] state are considered
--
-- This script expects output of [pactl list sinks]
-- piped to it's stdin

data Source =  PulseAudioSource
               Int     -- Source ID
               Bool    -- Is marked as running
               String  -- deivce.bus
               String  -- deivce.class
               String  -- deivce.form_factor
	       deriving (Show)

chooseSource :: [Source]         -- The list of sources yet to be processed
		-> Maybe Source  -- Here might be the currently selected source
		-> Maybe Int     -- Here might be the score of currently selected source
		-> Maybe Int     -- Output might be ID of the selected source
chooseSource [] source _
	| isJust source = Just id
	| otherwise = Nothing
	where (PulseAudioSource id _ _ _ _) = fromJust source
chooseSource (x:xs) maybeSource maybeTopScore
	| isJust maybeSource && topScore <= appraiseSource x = 
		chooseSource xs (Just x) (Just (appraiseSource x))
	| isJust maybeSource && topScore > appraiseSource x =
		chooseSource xs maybeSource maybeTopScore
	| otherwise = chooseSource xs (Just x) (Just (appraiseSource x))
	where source = fromMaybe (PulseAudioSource 0 False "" "" "") maybeSource
	      topScore = fromMaybe (-1) maybeTopScore

-- Assign points to source
appraiseSource :: Source -> Int
appraiseSource (PulseAudioSource id state dBus dClass dFormFactor)
    = sum ( map (uncurry (*)) ( zip powersOfTwo (reverse [
        boolToPoints state,
        boolToPoints (dBus == "bluetooth"),
        boolToPoints (dClass == "monitor"),
        boolToPoints (dFormFactor == "internal")
    ])))
    where powersOfTwo = iterate (2*) 2

boolToPoints :: Bool -> Int
boolToPoints True = 1
boolToPoints False = 0

main = undefined

