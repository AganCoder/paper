#  API

## 获取 Columns

API:     https://service.paper.meiyuan.in/api/v2/columns
参数： 无

```json

[{"_id":"5efb6009ae089fd1b96ded19","title":"latest","available":true,"langs":{"en":"latest","zh-Hans-CN":"最新","zh-Hant":"最新"}},
{"_id":"5efb6034ae089fd1b96ded1a","title":"popular","available":true,"langs":{"en":"popular","zh-Hans-CN":"最热","zh-Hant":"最熱"}},
{"_id":"5efb61158221945b4624c816","unsplash_id":"10643438","title":"Vertical","__v":989,"available":true,"langs":{"en":"vertical","zh-Hans-CN":"竖屏","zh-Hant":"竖屏"}}]

```

## 设置 Settings

API： https://service.paper.meiyuan.in/api/v2/settings
参数:  无

```json
{"_id":"5ef8fbf705332c3052aebb19","shouldUseUnsplashImage":false,"shouldUseUnsplashApi":false,"shouldUseUnsplashThumb":false,"shouldUploadStats":true,"__v":0}
```

## 获取对应页面数据

API：  https://service.paper.meiyuan.in/api/v2/columns/flow/{ _id }
参数:  
    page 第几页
    per_page 每页多少位

```json
[{
    "_id": "5f24a2738221945b46296593",
    "id": "1FxMET2U5dU",
    "created_at": "2016-05-06T17:46:59.000Z",
    "updated_at": "2020-07-28T05:30:01.000Z",
    "width": 2896,
    "height": 1944,
    "color": "#62ABDF",
    "description": null,
    "likes": 549,
    "download": 66599,
    "__v": 0,
    "from": "unsplash",
    "style": "standard",
    "urls": {
        "raw": "https://images.unsplash.com/photo-1462556791646-c201b8241a94",
        "full": "https://images.unsplash.com/photo-1462556791646-c201b8241a94?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjEyODYxfQ",
        "regular": "https://images.unsplash.com/photo-1462556791646-c201b8241a94?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyODYxfQ",
        "small": "https://images.unsplash.com/photo-1462556791646-c201b8241a94?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjEyODYxfQ",
        "thumb": "https://images.unsplash.com/photo-1462556791646-c201b8241a94?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjEyODYxfQ"
    },
    "links": {
        "self": "https://api.unsplash.com/photos/1FxMET2U5dU",
        "html": "https://unsplash.com/photos/1FxMET2U5dU",
        "download": "https://unsplash.com/photos/1FxMET2U5dU/download",
        "download_location": "https://api.unsplash.com/photos/1FxMET2U5dU/download"
    },
    "user": {
        "id": "dqhb2AHVbss",
        "username": "hjrc33",
        "name": "Héctor J. Rivas",
        "first_name": "Héctor J.",
        "last_name": "Rivas",
        "twitter_username": "Hectorjrivas",
        "bio": null,
        "location": null,
        "profile_image": {
            "small": "https://images.unsplash.com/profile-1461269002764-3aaf5a1a7657?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32",
            "medium": "https://images.unsplash.com/profile-1461269002764-3aaf5a1a7657?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64",
            "large": "https://images.unsplash.com/profile-1461269002764-3aaf5a1a7657?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"
        },
        "links": {
            "self": "https://api.unsplash.com/users/hjrc33",
            "html": "https://unsplash.com/@hjrc33",
            "photos": "https://api.unsplash.com/users/hjrc33/photos"
        }
    },
    "added_at": "2020-07-31T23:00:03.225Z"
}]

```

## 图片下载地址

http://paperimg.meiyuan.in/photo-1596415524580-7426d86a836a?imageView2/0/w/5120/interlace/1/q/80

https://service.paper.meiyuan.in/api/v2/photos/download/W04KYJ-rCeg


