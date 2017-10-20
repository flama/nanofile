import React, { Component } from 'react'

export default class AvatarUpload extends Component {
  state = {
    imagePreviewUrl: this.props.imageUrl,
    cached: false,
  }

  static defaultProps = {
    fieldName: 'avatar[hey]'
  }


  componentDidMount() {
    // this.presign = JSON.parse(this.props.presign)
    //
    // if (this.props.imageCache) {
    //   this.setState({ cached: true })
    // }
    //
    this.createInputFile()
    //
    // if (this.props.droparea) {
    //   this.setDropArea()
    // }
  }

  // setDropArea = () => {
  //   const droparea = document.querySelector(this.props.droparea)
  //
  //   droparea.ondragover = (event) => {
  //     event.preventDefault()
  //     droparea.classList.add(this.props.variant)
  //   }
  //
  //   droparea.ondragleave = (event) => {
  //     droparea.classList.remove(this.props.variant)
  //   }
  //
  //   droparea.ondrop = (event) => {
  //     event.preventDefault()
  //     droparea.classList.remove(this.props.variant)
  //
  //     const file = event.dataTransfer.files[0]
  //     this.preview(file)
  //     this.upload(file)
  //   }
  // }

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
    console.log('appended');
  }

  handleChange = (event) => {
    event.preventDefault()
    const file = event.target.files[0]
    this.preview(file)
    // this.upload(file)
  }

  preview = (file) => {
    let reader = new FileReader()

    reader.onloadend = () => {
      let img = new Image()
      img.src = reader.result
      img.onload = () => {
        this.setState({
          file: file,
          imagePreviewUrl: this.imageToCanvas(img).toDataURL()
        })
      }
    }
    reader.readAsDataURL(file)
  }

  presign = () => {
    return JSON.parse(this.props.presign)
  }

  // isValid = (file) => {
  //   this.errorMessages = []
  //
  //   if (!this.fileSizeUnder(file, 2000)) {
  //     this.errorMessages.push('Até 2MB')
  //   }
  //
  //   if (!this.fileTypeIncludes(file, /image\/.*/)) {
  //     this.errorMessages.push('Apenas imagens')
  //   }
  //
  //   if (!this.fileDimensionsAtLeast(file, {width: 160, height: 160})) {
  //     this.errorMessages.push('Mínimo 160x160 pixels')
  //   }
  //
  //   return this.errorMessages.length == 0
  // }

  // fileSizeUnder = (file, sizeInKB) => {
  //   return file.size / 1000 <= sizeInKB
  // }
  //
  // fileTypeIncludes = (file, allowedTypesRegex) => {
  //   return allowedTypesRegex.test(file.type)
  // }
  //
  // fileDimensionsAtLeast = () => true
  // // fileDimensionsAtLeast = async (file, dimensions) => {
  // //   return await this.fileToImage(file)
  // //     .then(image => image.width >= dimensions.width && image.height >= dimensions.heigth)
  // // }
  //
  // notifyErrors = () => {
  //   alert(this.errorMessages[0])
  // }

  // upload = (file) => {
  //   if (!this.isValid(file)) {
  //     return this.notifyErrors()
  //   }
  //
  //   let formData = new FormData()
  //
  //   Object.keys(this.presign.fields).forEach(key => {
  //     formData.append(key, this.presign.fields[key])
  //   })
  //
  //   formData.append('file', file)
  //
  //   fetch(this.presign.url, {
  //     method: 'post',
  //     body: formData
  //   })
  //   .then(data => this.setState({ cached: true }))
  // }

  imageToCanvas = (img) => {
    const canvas = document.createElement('canvas')
    canvas.width = this.props.width * 2 // retina support
    canvas.height = this.props.height * 2 // retina support
    return this.fillCanvasWithResizedImage(canvas, img)
  }

  fillCanvasWithResizedImage = (canvas, img) => {
    const dimensions = [...this.dimensionsToFill(canvas, img), 0, 0, canvas.width, canvas.height]
    canvas.getContext('2d').drawImage(img, ...dimensions)
    return canvas
  }

  dimensionsToFill = (canvas, img) => {
    var sourceWidth = img.width
    var sourceHeight = img.height

    if (img.width / img.height > canvas.width / canvas.height) {
      sourceWidth = img.height * canvas.width / canvas.height
    } else {
      sourceHeight = img.width * canvas.height / canvas.width
    }

    const sourceY = Math.floor((img.height - sourceHeight) / 2)
    const sourceX = Math.floor((img.width - sourceWidth) / 2)

    return [
      sourceX,
      sourceY,
      sourceWidth,
      sourceHeight,
    ]
  }

  cachedFile = () => {
    // const { key } = this.presign.fields
    //
    // return JSON.stringify({
    //   storage: 'cache',
    //   id: key.replace(/cache\//, ''),
    //   metadata: {},
    // })
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

      {/* { this.state.cached &&
        <input name={fieldName} type="hidden" value={this.cachedFile()} />
      } */}
    </div>)
  }
}
