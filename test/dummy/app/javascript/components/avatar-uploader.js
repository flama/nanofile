import React, { Component } from 'react'

export default class AvatarUploader extends Component {
  state = {
    imagePreviewUrl: this.props.imageUrl,
    cached: false,
  }

  static defaultProps = {
    fieldName: 'profile[avatar]'
  }

  componentWillMount() {
    if (this.props.imageCache) {
      this.setState({ cached: true })
    }
  }

  componentDidMount() {
    this.createInputFile()
  }

  // create an input for caching files in aws (isn't persistent)
  createInputFile = () => {
    let fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.id = this.props.fieldName

    fileInput.style.position = 'absolute'
    fileInput.style.overflow = 'hidden'
    fileInput.style.height = 0
    fileInput.style.top = `${this.label.offsetTop}px`
    fileInput.onchange = this.handleChange

    document.body.appendChild(fileInput)
  }

  handleChange = (event) => {
    event.preventDefault()
    const file = event.target.files[0]
    this.preview(file)
    this.upload(file)
  }

  preview = (file) => {
    let reader = new FileReader()

    reader.onloadend = () => {
      let img = new Image()
      img.src = reader.result
      this.setState({
        file: file,
        imagePreviewUrl: img.src
      })
    }
    reader.readAsDataURL(file)
  }

  isValid = (file) => {
    this.errorMessages = []

    if (!this.fileSizeUnder(file, 20000)) {
      this.errorMessages.push('Até 2MB')
    }

    if (!this.fileTypeIncludes(file, /image\/.*/)) {
      this.errorMessages.push('Apenas imagens')
    }

    return this.errorMessages.length == 0
  }

  fileSizeUnder = (file, sizeInKB) => {
    return file.size / 1000 <= sizeInKB
  }

  fileTypeIncludes = (file, allowedTypesRegex) => {
    return allowedTypesRegex.test(file.type)
  }

  notifyErrors = () => {
    alert(this.errorMessages[0])
  }

  upload = (file) => {

    if (!this.isValid(file)) {
      return this.notifyErrors()
    }

    let formData = new FormData()

    Object.keys(this.props.presign.fields).forEach(key => {
      formData.append(key, this.props.presign.fields[key])
    })

    formData.append('file', file)

    fetch(this.props.presign.url, {
      method: 'post',
      body: formData
    })
    .then(data => this.setState({ cached: true }))
    .then(console.log)
    .catch(console.error)
  }

  cachedFile = () => {
    const { key } = this.props.presign.fields

    return JSON.stringify({
      storage: 'cache',
      id: key.replace(/cache\//, ''),
      metadata: {},
    })
  }

  render() {
    const { fieldName } = this.props
    const { imagePreviewUrl } = this.state

    return (<div className="uploader">
      <label
        htmlFor={fieldName}
        className="image-container"
        onClick={this.handleClick}
        ref={label => this.label = label}
      >
        {imagePreviewUrl && <img src={imagePreviewUrl} className="image-container" />}
        <div className="overlay"></div>
      </label>

      {/* Creates the persistent file upload */}
      { this.state.cached &&
        <input name={fieldName} type="hidden" value={this.cachedFile()} />
      }
    </div>)
  }
}
