## Part 2
It's slow because there are no indexes (besides the default) so the whole collection needs to be scanned.

Also specifically for this agg pipeline, the sort is not necessary which is more than doubling the time.
## Part 3
An index on user_id `{user_id: 1}` should be sufficient to make the query sufficiently fast. If further optimization is necessary a compound index on user_id and system_time could be next `{user_id: 1, system_time: -1}`, system_time is stored in desc order instead of asc assuming that we generally want the latest entries.

## Part 4
Our index from above would do a big job of speeding this up. The best for this specific query would be a partial index. Assuming the pending state is rare this should also result in a tiny index alongside being very fast

`db.data_points.createIndex({user_id: 1, "cgm.device_guid": 1}, {partialFilterExpression: {pending: true}})`

## Part 5
We'd use a partial index for this `db.data_points.createIndex({user_id: 1}, {partialFilterExpression: {glucose_value: {$lt: 5400}}})`

## Part 6
We could consolidate the indexes into 1-2 indexes for all queries, but we're probably fine leaving the partial indexes from part 4 and 5, they are relatively tiny (<5MB combined).