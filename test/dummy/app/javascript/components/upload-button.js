import React, { Component } from 'react'
import PropTypes from 'prop-types'

import peek from '../helpers/peek'

export default class UploadButton extends Component {
  static propTypes = {
    presignPath: PropTypes.string.isRequired,
    promotePath: PropTypes.string.isRequired,
  }

  state = {
    uploading: false,
    imageSrc: null,
  }

  headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  }

  preview = (file) => {
    let reader = new FileReader()

    reader.onloadend = () => {
      this.setState({
        uploading: true,
        imageSrc: reader.result
      })
    }

    reader.readAsDataURL(file)
  }

  upload = (file) => {
    const {
      presignPath,
      promotePath,
    } = this.props

    fetch(presignPath, {
      credentials: 'same-origin',
      headers: {
        Accept: 'application/json',
      },
    })
    .then(r => r.json())
    .then(presign => {
      let formData = new FormData()

      Object.keys(presign.fields).forEach(key => {
        formData.append(key, presign.fields[key])
      })

      formData.append('file', file)

      return fetch(presign.url, {
        method: 'POST',
        body: formData,
      })
      .then(r => presign.fields.key.replace(/cache\//, ''))
      .catch((error) => {
        console.error('aws upload', error)
      })
    })
    .then(fileName => fetch(promotePath, {
      method: 'post',
      credentials: 'same-origin',
      headers: this.headers,
      body: JSON.stringify({
        image: JSON.stringify({
          "id": fileName,
          "storage": "cache",
          "metadata": {}
        })
      })
    }))
    .then(imageUpload => {
      this.setState({
        uploading: false,
      })
    })
    .catch(error => {
      console.error('rails upload', error)
    })
  }

  handleChange = (event) =>{
    event.preventDefault()
    const file = event.target.files[0]
    this.preview(file)
    this.upload(file)
  }

  render() {
    const { imageSrc, uploading } = this.state

    return (
      <div className="upload-container">
        <label className="upload-button" htmlFor="image-upload-editor">
          Upload button
          <input
            id="image-upload-editor"
            type="file"
            onChange={this.handleChange}
            style={{
              height: 0,
              position: 'absolute',
              overflow: 'hidden',
            }}
            accept="image/*"
          />
        </label>

        {imageSrc && <img
          src={imageSrc}
          style={{
            marginTop: '2em',
            width: '100%',
            opacity: uploading ? .8 : 1
          }}
        />}
      </div>
    )
  }
}
