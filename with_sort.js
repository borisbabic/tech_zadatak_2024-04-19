db.getCollection('data_points').aggregate(
[
{ $sort: { user_id: 1 } },
{
$group: {
_id: '$user_id',
count: { $sum: 1 }
}
},
{ $sort: { count: -1 } }
],
{ maxTimeMS: 0, allowDiskUse: true }
);
